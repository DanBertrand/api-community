class Api::V1::JobsController < ApplicationController
  before_action :set_job, only: %i[show update apply destroy]

  # GET /jobs
  def index
    @jobs = Job.all
    render_jobs =
      @jobs.map do |job|
        JobSerializer.new(job).serializable_hash[:data][:attributes]
      end
    render json: { data: render_jobs }, status: :ok
  end

  # GET /jobs/1
  def show
    render json: @job
  end

  # POST /jobs
  def create
    @job = Job.new(job_params)
    @job.community = Community.find(params[:community_id])
    if @job.save
      render json: {
               message: I18n.t('job_create_success'),
               data:
                 JobSerializer.new(@job).serializable_hash[:data][:attributes],
             },
             status: :ok
    else
      render json: {
               error:
                 I18n.t('job_create_fail') +
                   " #{@job.errors.full_messages.to_sentence}",
             },
             status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jobs/1
  def update
    if @job.update(job_params)
      render json: @job
    else
      render json: {
               error: @job.errors.full_messages.to_sentence,
             },
             status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jobs/:id/apply
  def apply
    if current_user.apply(@job)
      render json: @job
    else
      render json: {
               error: current_user.apply(@job),
             },
             status: :unprocessable_entity
    end
  end

  # DELETE /jobs/1
  def destroy
    if @job.destroy
      render json: { message: I18n.t('job_delete_success') }, status: :ok
    else
      render json: { error: I18n.t('job_delete_fail') }, status: 400
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_job
    @job = Job.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def job_params
    params
      .require(:job)
      .permit(
        :title,
        :description,
        :duration_in_days,
        :nbr_of_person_required,
        :community_id,
        :user_id,
      )
  end
end

class Api::V1::WorkshopsController < ApplicationController
  before_action :set_workshop, only: %i[show update destroy]

  # GET /workshops
  def index
    @workshops = Workshop.all
    render_workshops =
      @workshops.map do |workshop|
        WorkshopSerializer.new(workshop).serializable_hash[:data][:attributes]
      end
    render json: { data: render_workshops }, status: :ok
  end

  # GET /workshops/1
  def show
    render json: @workshop
  end

  # POST /workshops
  def create
    @workshop = Workshop.new(workshop_params)
    @workshop.community = Community.find(params[:community_id])
    if @workshop.save
      render json: {
               message: I18n.t('workshop_create_success'),
               data:
                 WorkshopSerializer.new(@workshop).serializable_hash[:data][
                   :attributes
                 ],
             },
             status: :ok
    else
      render json: @workshop.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /workshops/1
  def update
    if @workshop.update(workshop_params)
      render json: @workshop
    else
      render json: @workshop.errors, status: :unprocessable_entity
    end
  end

  # DELETE /workshops/1
  def destroy
    if @workshop.destroy
      render json: { message: I18n.t('workshop_delete_success') }, status: :ok
    else
      render json: { message: I18n.t('workshop_delete_fail') }, status: 400
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_workshop
    @workshop = Workshop.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def workshop_params
    params
      .require(:workshop)
      .permit(:title, :description, :community_id, :user_id)
  end
end

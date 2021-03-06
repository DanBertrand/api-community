class Api::V1::CommunitiesController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :set_community, only: %i[show update destroy]

  def index
    begin
      @communities = Community.all
    rescue => errors
      render json: {
               error: I18n.t('community_index_fail') + " #{errors.message}}",
             },
             status: :not_found
    else
      render_communites =
        @communities.map do |community|
          CommunitySerializer.new(community).serializable_hash[:data][
            :attributes
          ]
        end
      render json: { data: render_communites }, status: :ok
    end
  end

  def show
    begin
      @community
    rescue => errors
      render json: {
               error: I18n.t('community_show_fail') + " #{errors.message}",
             },
             status: :not_found
    else
      render json: {
               data:
                 CommunitySerializer.new(
                   @community,
                   params: {
                     current_user: current_user,
                   },
                 ).serializable_hash[
                   :data
                 ][
                   :attributes
                 ],
             },
             status: :ok
    end
  end

  def create
    @community = Community.create(community_params)
    @community.add_address(params)
    @community.add_creator(current_user)
    if @community.save
      render json: {
               data:
                 CommunitySerializer.new(@community).serializable_hash[:data][
                   :attributes
                 ],
               message: I18n.t('community_create_success'),
             },
             status: :ok
    else
      render json: {
               error:
                 I18n.t(' community_create_fail') +
                   " #{@member.errors.full_messages.to_sentence} #{@community.errors.full_messages.to_sentence}",
             },
             status: :bad_request
    end
  end

  private

  def set_community
    @community = Community.find(params[:id])
  end

  def community_params
    params
      .require(:community)
      .permit(
        :name,
        :address,
        :description,
        :formatted_address,
        :latitude,
        :longitude,
        :house_number,
        :street,
        :post_code,
        :state,
        :city,
        :country,
      )
  end
end

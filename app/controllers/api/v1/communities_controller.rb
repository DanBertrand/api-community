
class Api::V1::CommunitiesController < ApplicationController
  respond_to :json
  before_action :authenticate_user! , only: %i[create update destroy]
  before_action :set_community, only: %i[show update destroy]

  def index
    @communities = Community.all
    render json: @communities
  end

  def show
    render json:{
      data: CommunitySerializer.new(@community).serializable_hash[:data][:attributes]
    }
  end


  def create
    @community = Community.new(community_params)
    @community.user = current_user
    if @community.save
      render json:{
        data: CommunitySerializer.new(@community).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        error:
          "Unable to save the community. #{resource.errors.full_messages.to_sentence}",
       }
    end
  end

  private
  def set_community
    @community = Community.find(params[:id])
  end

  def community_params
    params.require(:community).permit(:name)
  end

end

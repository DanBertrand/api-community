class Api::V1::User::CommunitiesController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def index
    @user_communities = current_user.communities_with_member_info
    render json: {
             data: {
               total_count: current_user.communities.length,
               data: @user_communities,
             },
           }
  end
end

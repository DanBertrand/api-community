class Api::V1::User::CommunitiesController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def index
    @creator = current_user.communities_creator
    @member = current_user.communities_member
    if @creator && @member
    render json:{
      data: {
        total_count:  current_user.communities.length,
        creator:   @creator,
        member: @member
      }
    }
    elsif !@creator
      render json:{
        data: {
          total_count:  current_user.communities.length,
          member: @member
        }
      }
    elsif !@member
      render json:{
        data: {
          total_count:  current_user.communities.length,
          creator:   @creator,
        }
      }
    end
  end

end


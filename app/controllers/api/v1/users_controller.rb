class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def show
    render json:{
      data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
    }
  end
end


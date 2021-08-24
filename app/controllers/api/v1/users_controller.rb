class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def show
    render json:{
      data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
    }
  end

  def update

    current_user.update(user_params)
    render json:{
      data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
    }
  end



  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
end


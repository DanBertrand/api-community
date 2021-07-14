class Api::ProfileController < ApplicationController
  before_action :authenticate_user!


  def show
    render json: current_user
  end



  # def show
  #   if user_signed_in?
  #     render json: current_user
  #   else
  #     render json: {
  #       errors: [
  #         {
  #           status: '400',
  #           title: 'Bad Request',
  #           detail: 'Please sign in',
  #           code: '400'
  #         }
  #       ]
  #     }, status: :bad_request
  #   end
  # end
end

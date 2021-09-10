class Api::V1::MembersController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :set_member, only: %i[destroy]

  def create
    @member =
      Member.new(user_id: params[:user_id], community_id: params[:community_id])
    if @member.save
      render json: { data: @member }, status: :ok
    else
      render json: {
               error:
                 "Unable to join the community. #{@member.errors.full_messages.to_sentence} ",
             },
             status: :bad_request
    end
  end

  def destroy
    if @member.destroy
      render json: { data: @member }, status: :ok
    else
      render json: {
               error:
                 "Unable to join the community. #{@member.errors.full_messages.to_sentence} ",
             },
             status: :bad_request
    end
  end

  # private

  def set_member
    @member = Member.find(params[:id])
  end

  # def member_params
  #   params.require(:member).permit(:user_id, :community_id)
  # end
end

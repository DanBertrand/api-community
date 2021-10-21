class Api::V1::User::AvatarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_avatar, only: %i[update destroy]
  respond_to :json

  def create
    image = Cloudinary::Uploader.upload(params[:image])
    current_user.avatar.total_destroy if current_user.avatar
    if Avatar.create(
         user_id: current_user.id,
         url: image['url'],
         public_id: image['public_id'],
       )
      render json: {
               data:
                 UserSerializer.new(current_user).serializable_hash[:data][
                   :attributes
                 ],
               message: 'Avatar updated successfully',
             },
             status: :ok
    else
      render json: {
               error:
                 "Unable to save the profile picture. #{avatar.errors.full_messages.to_sentence}",
             },
             status: :bad_request
    end
  end

  def destroy
    if @avatar.total_destroy
      render json: {
               data:
                 UserSerializer.new(current_user).serializable_hash[:data][
                   :attributes
                 ],
               message: 'Avatar deleted successfully',
             }
    else
      render json: {
               error:
                 "Unable to delete the avatar #{@avatar.errors.full_messages.to_sentence}",
             },
             status: :bad_request
    end
  end

  private

  def set_avatar
    @avatar = Avatar.find(params[:id])
  end

  # def avatar_params
  #   params.require(:avatar).permit(:url, :public_url)
  # end
end

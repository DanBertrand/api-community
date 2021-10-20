class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show update]

  def show
    render json: {
             data:
               UserSerializer.new(current_user).serializable_hash[:data][
                 :attributes
               ],
           }
  end

  def update
    if current_user.update(user_params)
      render json: {
               data:
                 UserSerializer.new(current_user).serializable_hash[:data][
                   :attributes
                 ],
             },
             status: :ok,
             code: '200',
             message: I18n.t(' account_update_success')
    else
      render json: {
               error:
                 I18n.t('  account_update_fail') +
                   " #{current_user.errors.full_messages.to_sentence}",
             },
             status: :unprocessable_entity
    end
  end

  def confirmation_token
    user = User.find_by(confirmation_token: params[:token])
    if user
      render json: {
               data:
                 UserSerializer.new(user).serializable_hash[:data][:attributes],
             },
             status: :ok,
             code: '200',
             message: 'User found'
    else
      render json: {
               error:
                 "Couldn't find any users. #{user.errors.full_messages.to_sentence}",
             },
             status: :unprocessable_entity
    end
  end

  # GET
  def request_new_link
    user = User.find_by(confirmation_token: params[:token])
    if !user.confirmed?
      user.resend_confirmation_instructions
      render json: {
               message: I18n.t('email_confirmation_sent'),
             },
             status: :ok,
             code: '200'
    else
      render json: {
               message: I18n.t('email_confirmation_sent'),
             },
             status: :ok,
             code: '200'
    end
  end

  private

  def user_params
    params.permit(
      :email,
      :password,
      :password_confirmation,
      :current_password,
      :first_name,
      :last_name,
      :account_update,
    )
  end
end

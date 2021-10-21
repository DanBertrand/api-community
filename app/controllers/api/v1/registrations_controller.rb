class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
               status: {
                 code: 200,
                 message: I18n.t('signup_success'),
               },
               data:
                 UserSerializer.new(resource).serializable_hash[:data][
                   :attributes
                 ],
             }
    else
      render json: {
               message:
                 I18n.t('signup_fail') +
                   "#{resource.errors.full_messages.to_sentence}",
             },
             status: :unprocessable_entity
    end
  end

  def edit
    render json: {
             status: {
               code: 200,
             },
             message: 'Editing profile',
             data:
               UserSerializer.new(resource).serializable_hash[:data][
                 :attributes
               ],
           }
  end

  def update
    custom_params = registration_update_params

    begin
      if current_user.valid_password?(custom_params[:password])
        if custom_params[:new_password] != '' &&
             custom_params[:new_password] ==
               custom_params[:new_password_confirmation]
          custom_params[:password] = custom_params[:new_password]
        end
        current_user.update(
          custom_params.except(:new_password, :new_password_confirmation),
        )
        render json: {
                 message: I18n.t('profile_update_success'),
                 data:
                   UserSerializer.new(current_user).serializable_hash[:data][
                     :attributes
                   ],
               },
               status: :ok
      else
        render json: { error: I18n.t('wrong_password') }, status: :bad_request
      end
    rescue => errors
      render json: {
               error:
                 I18n.t('profile_update_fail') +
                   " #{errors.full_messages.to_sentence}",
             },
             status: :unprocessable_entity
    end
  end

  private

  def registration_update_params
    params
      .require(:account_update)
      .permit(
        :email,
        :password,
        :password_confirmation,
        :new_password,
        :new_password_confirmation,
        :first_name,
        :last_name,
      )
  end
end

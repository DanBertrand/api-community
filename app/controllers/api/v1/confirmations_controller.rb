class Api::V1::ConfirmationsController < Devise::ConfirmationsController
  respond_to :json

  # GET /resource/confirmation/new
  def new
    self.resource = resource_class.new
  end

  # POST /resource/confirmation
  def create
    self.resource =
      resource_class.send_confirmation_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_with(
        {},
        location:
          after_resending_confirmation_instructions_path_for(resource_name),
      )
    else
      respond_with(resource)
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      render json: {
               message: 'Your email has been confirmed successfully',
             },
             status: :ok
    else
      render json: {
               error:
                 "An error occured. #{resource.errors.full_messages.to_sentence}",
             },
             status: :unprocessable_entity
    end
  end

  protected

  # The path used after resending confirmation instructions.
  def after_resending_confirmation_instructions_path_for(resource_name)
    is_navigational_format? ? new_session_path(resource_name) : '/'
  end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    if signed_in?(resource_name)
      signed_in_root_path(resource)
    else
      new_session_path(resource_name)
    end
  end

  def translation_scope
    'devise.confirmations'
  end
end

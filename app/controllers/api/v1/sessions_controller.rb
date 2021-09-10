class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    user = User.find_by(email: params[:user][:email])
    if !user.confirmed?
      render json: {
               status: 401,
               message: 'Please confirm your email in order to login',
             },
             status: :unauthorized
    elsif user.confirmed?
      self.resource = warden.authenticate!(auth_options)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end

  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    yield resource if block_given?
    respond_with(resource, serialize_options(resource))
  end

  private

  def respond_with(resource, _opts = {})
    if current_user
      render json: {
               status: {
                 code: 200,
                 message: 'Logged in successfully.',
               },
               data:
                 UserSerializer.new(resource).serializable_hash[:data][
                   :attributes
                 ],
             }
    else
      render json: {
               status: 401,
               message:
                 "Couldn't find an active session. #{resource.errors.full_messages.to_sentence}",
             },
             status: :unauthorized
    end
  end

  def respond_to_on_destroy
    head :no_content
  end
end

class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json
  # before_action :authenticate_user!
  private

  def respond_with(resource, _opts = {})
    if current_user
      render json: {
        status: {
          code: 200,
          message: 'Logged in successfully.',
        },
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes],
      }
    else
      render json: {
              status: 401,
              message: "Couldn't find an active session.",
            },
            status: :unauthorized
    end
  end


  def respond_to_on_destroy
    head :no_content
  end

end


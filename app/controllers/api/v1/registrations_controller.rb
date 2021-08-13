class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  # def create
  #   build_resource(sign_up_params)

  #   resource.save
  #   sign_up(resource_name, resource) if resource.persisted?
  #   render_resource(resource)
  # end
  def respond_with(resource, _opts = {})
  if resource.persisted?
    render json: {
             status: {
               code: 200,
               message: 'Signed up sucessfully.',
             },
             data: UserSerializer.new(resource).serializable_hash[:data][:attributes],
           }
  else
    render json: {
            error:
              "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}",
           },
           status: :unprocessable_entity
  end
end


end

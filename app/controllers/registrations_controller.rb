class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)
    if resource.save
      sign_up(resource_name, resource) if resource.persisted?
      render_resource(resource)
    else
      render json: {
        errors: [
          {
            status: '400',
            title: 'Bad Request',
            detail: resource.errors.messages,
            code: '400'
          }
        ]
      }, status: :bad_request
    end
  end

end

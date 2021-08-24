class ApplicationController < ActionController::API
  respond_to :json
  def render_resource(resource)
    if resource.errors.empty?

      render json: resource
    else

      validation_error(resource)
    end
  end

  def validation_error(resource)
    render json: {
          errors: resource.errors,
    }
  end


end

class ApplicationController < ActionController::API
  before_action :configure_permitted_params, if: :devise_controller?
  before_action :set_locale

  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource)
    end
  end

  def validation_error(resource)
    render json: { errors: resource.errors }
  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    if I18n.available_locales.map(&:to_s).include?(parsed_locale)
      parsed_locale
    else
      nil
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end

  protected

  def configure_permitted_params
    devise_parameter_sanitizer.permit(:sign_up) do |user|
      user.permit(
        :first_name,
        :last_name,
        :email,
        :password,
        :password_confirmation,
        :current_password,
      )
    end
    devise_parameter_sanitizer.permit(:account_update) do |user|
      user.permit(
        :first_name,
        :last_name,
        :email,
        :password,
        :password_confirmation,
        :current_password,
      )
    end
    devise_parameter_sanitizer.permit(:destroying) do |user|
      user.permit(
        :first_name,
        :last_name,
        :email,
        :password,
        :password_confirmation,
        :current_password,
      )
    end
  end
end

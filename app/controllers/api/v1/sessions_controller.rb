class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json

  before_action :set_locale

  def create
    user = params[:user] ? User.find_by(email: params[:user][:email]) : nil

    # binding.pry
    if user && !user.confirmed?
      render json: {
               status: 401,
               message: I18n.t('email_confirmation_request'),
               data:
                 UserSerializer.new(user).serializable_hash[:data][:attributes],
             },
             status: :unauthorized
    elsif !user || user.confirmed?
      # binding.pry
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

  def respond_with(resource, _opts = {})
    if current_user
      render json: {
               status: {
                 code: 200,
               },
               data:
                 UserSerializer.new(resource).serializable_hash[:data][
                   :attributes
                 ],
               message: I18n.t('login_success'),
             }
    else
      render json: {
               status: 401,
               message:
                 I18n.t('login_fail') +
                   " #{resource.errors.full_messages.to_sentence}",
             },
             status: :unauthorized
    end
  end
  def respond_to_on_destroy
    I18n.locale = extract_locale
    render json: { message: I18n.t('logout') }, status: 200
  end
end

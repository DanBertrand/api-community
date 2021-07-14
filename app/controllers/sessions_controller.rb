class SessionsController < Devise::SessionsController
  

  def create
    user = User.find_by("email":params[:user][:email])
    if user
      super do |resource|
       
      end
    else
      render json: {
      errors: [
        {
          status: '400',
          title: 'Bad Request',
          detail: 'Invalid email',
          code: '400'
        }
      ]
    }, status: :bad_request
    end
  end

  def new
    if user_signed_in?
      render json: current_user
    else
      render json: {
        errors: [
          {
            status: '400',
            title: 'Bad Request',
            detail: 'An error occurs during the anthentication',
            code: '400'
          }
        ]
      }, status: :bad_request
    end
  end

 



  private

  def respond_with(resource, _opts = {})
  # binding.pry
  begin user = User.where(email:resource.email)
    if user
    render json: resource
    end
 
  rescue => e
    render json: {error: e, status: 500}.to_json
  end
  end

  def respond_to_on_destroy
    head :no_content
  end
end


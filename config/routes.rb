Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users, 
  path: 'api/v1/',
  path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    registrations: 'api/v1/registrations',
    sessions: 'api/v1/sessions'
  }

  namespace :api do
    namespace :v1 do
      get '/profile', to: "users#show"
      resources :communities, only: [:index, :show, :create] 
      namespace :user do
        get '/communities', to: "communities#index"
      end
    end
  end
  
end

Rails
  .application
  .routes
  .draw do
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

    scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
      devise_for :users,
                 path: '',
                 path_names: {
                   sign_in: 'api/v1/login',
                   sign_out: 'api/v1/logout',
                   registration: 'api/v1/signup',
                   confirmation: 'confirmation',
                 },
                 controllers: {
                   registrations: 'api/v1/registrations',
                   sessions: 'api/v1/sessions',
                   confirmations: 'api/v1/confirmations',
                 }

      namespace :api do
        namespace :v1 do
          get '/profile', to: 'users#show'
          get '/user/confirmation_token/:token', to: 'users#confirmation_token'
          get '/user/confirmation/request_new_link/:token',
              to: 'users#request_new_link'
          put '/profile', to: 'users#update'
          resources :communities, only: %i[index show create] do
            resources :members, only: %i[create destroy]
            resources :workshops, :jobs do
              resources :applies
            end
            # patch '/jobs/:id/apply', to: 'jobs#apply'
          end
          namespace :user do
            get '/communities', to: 'communities#index'
          end
          namespace :user do
            resources :avatars
          end
        end
      end
    end
  end

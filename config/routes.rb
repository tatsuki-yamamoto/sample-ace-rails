Rails.application.routes.draw do
  namespace :api, format: 'json' do
    namespace :v1 do
      devise_scope :auth do
        mount_devise_token_auth_for 'User', at: 'auth', controllers: {
          registrations: 'api/v1/auth/registrations',
        }
      end
      resources :todos
    end
  end
end

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # devise_for :users
  
  namespace :api, defaults: { format: 'json' } do
    resources :users
    resources :billionaires, except: [:update]
    resources :appointments
  end

  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
    controllers tokens: 'custom_tokens'
  end
end

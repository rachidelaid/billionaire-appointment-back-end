Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # devise_for :users
  
  namespace :api, defaults: { format: 'json' } do
    resources :users, only: :create
    resources :billionaires, except: :update
    resources :appointments, except: :update
  end

  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
    controllers tokens: 'custom_tokens'
  end
end

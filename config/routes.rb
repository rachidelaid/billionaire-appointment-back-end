Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  
  namespace :api, defaults: { format: 'json' } do
    resources :users
    resources :billionaires
    resources :appointments
  end
end

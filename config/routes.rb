Rails.application.routes.draw do
  root to: 'top#index'
  devise_for :users, only: [:sign_in, :sign_out, :session]
  namespace :admin do
    root to: 'top#index'
    resources :sessions do
      put '/activate' => 'sessions#activate', as: :activate
      put '/inactivate' => 'sessions#inactivate', as: :inactivate
      resources :missions
    end
  end
end

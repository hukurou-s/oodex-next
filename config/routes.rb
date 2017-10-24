Rails.application.routes.draw do
  root 'top#index'
  devise_for :users, only: [:sign_in, :sign_out, :session]
end

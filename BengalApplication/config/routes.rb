Rails.application.routes.draw do

  devise_for :users
  resources :users
  resources :user_log_in
  # For details on the SL available within this file, see http://guides.rubyonrails.org/routing.html
end

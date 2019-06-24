Rails.application.routes.draw do

  devise_for :users


  resources :teachers do
    resources :students
  end
  root 'homeroutes#route'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end

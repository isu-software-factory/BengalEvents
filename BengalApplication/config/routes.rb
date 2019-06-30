Rails.application.routes.draw do
  devise_for :users
  resources :teachers do
    resources :students
  end
  resources :occasions do
    resources :events
  end

  root 'homeroutes#routes'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end

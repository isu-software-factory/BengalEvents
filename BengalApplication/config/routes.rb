Rails.application.routes.draw do
  resources :teachers do
    resources :students
  end
  resources :occasions do
    resources :events
  end
  resources :users, only: [:index, :show, :update, :destroy]

  root 'homeroutes#routes'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end

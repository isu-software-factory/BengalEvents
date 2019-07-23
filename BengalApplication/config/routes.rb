Rails.application.routes.draw do
  devise_for :users, skip: :devise_registration
 # devise_for :users, skip: :devise_registration
  resources :teachers
  resources :students
  resources :sponsors
  get "registrations/register/:id" => "registrations#register"
  get "registrations/events/:id" => "registrations#events"
  resources :coordinators
  resources :registrations
  post 'teams/register_members' => "teams#register_members"
  get "teams/register" => "teams#register"
  resources :teams

  resources :occasions do
    resources :events do
      resources :event_details
    end
  end

  get "homeroutes/routes" => 'homeroutes#routes'
  root 'homeroutes#routes'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end

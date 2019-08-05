Rails.application.routes.draw do
  devise_for :users, skip: :devise_registration
  # devise_for :users, skip: :devise_registration
  resources :teachers
  resources :students
  resources :sponsors
  get 'registrations/index/:part_id' => "registrations#index"
  get "registrations/register/:part_id/:id" => "registrations#register"
  get "registrations/events/:part_id/:id" => "registrations#events"
  resources :coordinators
  post 'teams/register_members' => "teams#register_members"
  get "teams/register" => "teams#register"

  get "slots/:name" => "events#location_timeslots"
  resources :teams

  resources :occasions do
    resources :locations do
      resources :time_slots
    end
    resources :events do
      resources :event_details
    end
  end


  resources :time_slots

  get "homeroutes/routes" => 'homeroutes#routes'
  root 'homeroutes#routes'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end

Rails.application.routes.draw do
  get 'groupings/add'
  devise_for :users, skip: :devise_registration
  # devise_for :users, skip: :devise_registration
  resources :teachers
  resources :students
  resources :sponsors
  resources :coordinators
  get "groupings/add/:id/:team_id" => "groupings#add"
  get 'registrations/index/:part_id' => "registrations#index"
  get "registrations/register/:part_id/:id" => "registrations#register"
  get "registrations/events/:part_id/:id" => "registrations#events"
  post 'teams/:id/register_members' => "teams#register_members"
  get "teams/:id/invite" => "teams#invite"
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

  get "homeroutes/routes" => 'homeroutes#routes'
  root 'homeroutes#routes'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end

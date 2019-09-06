Rails.application.routes.draw do
  get 'groupings/add'
  devise_for :users, skip: :devise_registration

  resources :teachers
  resources :students
  resources :sponsors
  resources :coordinators
  get "teachers/class_registrations/:id" => "teachers#class_registrations"
  get "students/schedule/:id" => "students#schedule"
  get "groupings/add/:id/:team_id" => "groupings#add"
  get 'registrations/index/:part_id' => "registrations#index"
  get "registrations/register/:part_id/:id" => "registrations#register"
  get "registrations/events/:part_id/:id" => "registrations#events"
  post 'teams/:id/register_members' => "teams#register_members"
  get "teams/:id/invite" => "teams#invite"
  post "groupings/drop/:part_id/:id" => "groupings#drop"
  post "registrations/drop/:part_id/:id" => "registrations#drop"
  get "registrations/add_to_waitlist/:part_id/:id" => "registrations#add_to_waitlist"
  get "slots/:name" => "events#location_timeslots"

  resources :teams
  resources :occasions do
    resources :locations
    resources :events do
      resources :event_details
    end
  end

  get "homeroutes/routes" => 'homeroutes#routes'
  root 'homeroutes#routes'
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end

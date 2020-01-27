Rails.application.routes.draw do
  get 'groupings/add'
  devise_for :users, skip: [:devise_registration]
  as :user do
    get 'sign_in', to: 'homeroutes#routes'
    get 'sign_up', to: 'homeroutes#routes'
  end

  resources :admins
  resources :teachers
  resources :students
  resources :sponsors
  resources :coordinators

  get "sponsors/pdf/:id" => "sponsors#pdfshow"
  get "teams/pdf/:id" => "teams#teamschedulepdf"
  get "teachers/class_registrations/:id" => "teachers#class_registrations"
  get "students/schedule/:id" => "students#schedule"
  get "students/print_schedule/:id" => "students#print_schedule"
  get "groupings/add/:id/:team_id" => "groupings#add"
  get 'registrations/index/:part_id' => "registrations#index"
  post "registrations/register/:part_id/:id" => "registrations#register"
  get "registrations/events/:part_id/:id" => "registrations#events"
  post 'teams/:id/register_members' => "teams#register_members"
  get "teams/:id/invite" => "teams#invite"
  post "groupings/drop/:part_id/:id" => "groupings#drop"
  post "registrations/drop/:part_id/:id" => "registrations#drop"
  post "registrations/add_to_waitlist/:part_id/:id" => "registrations#add_to_waitlist"
  get "slots/:name" => "events#location_timeslots"
  post "students/update_new_students" => "students#update_new_students"
  get "register/:id" => "registrations#registers"


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

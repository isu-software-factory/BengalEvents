Rails.application.routes.draw do
  get 'groupings/add'
  devise_for :users, skip: [:devise_registration]
  as :user do
    get 'sign_in', to: 'homeroutes#home'
    get 'sign_up', to: 'homeroutes#home'
  end

  resources :admins
  resources :coordinators
  get "events/index/:role/:id" => "events#index"
  get "sponsors/pdf/:id" => "sponsors#pdfshow"
  get "teams/pdf/:id" => "teams#teamschedulepdf"
  get "students/schedule/:id" => "students#schedule"
  get "students/print_schedule/:id" => "students#print_schedule"
  get "groupings/add/:id/:team_id" => "groupings#add"
  get 'registrations/index/:part_id' => "registrations#index"
  # post "registrations/register/:part_id/:id" => "registrations#register"
  post "registrations/register/:user_id/:id" => "registrations#register"



  get "registrations/activities/:part_id/:id" => "registrations#activities"
  post 'teams/:id/register_members' => "teams#register_members"
  get "teams/:id/invite" => "teams#invite"
  post "groupings/drop/:part_id/:id" => "groupings#drop"
  post "registrations/drop/:role/:session_id/:id" => "registrations#drop"
  post "registrations/add_to_waitlist/:part_id/:id" => "registrations#add_to_waitlist"
  get "slots/:name" => "activities#location_timeslots"
  post "students/update_new_students" => "students#update_new_students"

  get "activities/get_locations" => "activities#get_locations"
  get "activities/get_rooms/:location" => "activities#get_rooms"
  get "register/:role/:session_id/:id" => "registrations#registers"

  post "students/errors" => "students#errors"
  resources :teams
resources :events
  resources :activities
  # resources :teams
  # resources :EventsController do
  #   resources :locations
  #   resources :ActivitiesController do
  #     resources :sessions
  #   end
  # end

  get "/drop_activity/:role/:session_id/:id" => "registrations#drop_activity"
  get "homeroutes/home" => 'homeroutes#home'
  get 'homeroutes/user/:id' => 'homeroutes#user', as: "profile"
  get "homeroutes/new/:name" => "homeroutes#new", as: "new_user"
  post "homeroutes/create" => "homeroutes#create"
  root 'homeroutes#home'
  post 'homeroutes/reset_password/:id' => "homeroutes#reset_password", as: "reset_password"
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end

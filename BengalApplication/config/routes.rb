Rails.application.routes.draw do
  get 'groupings/add'
  devise_for :users, skip: [:devise_registration]
  as :user do
    get 'sign_in', to: 'homeroutes#home'
    get 'sign_up', to: 'homeroutes#home'
  end

  resources :admins
  resources :coordinators
  get "teachers/:id" => "teachers#show"
  get "sponsors/pdf/:id" => "sponsors#pdfshow"
  get "teams/pdf/:id" => "teams#teamschedulepdf"
  get "teachers/class_registrations/:id" => "teachers#class_registrations"
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
  post "registrations/drop/:user_id/:id" => "registrations#drop"
  post "registrations/add_to_waitlist/:part_id/:id" => "registrations#add_to_waitlist"
  get "slots/:name" => "activities#location_timeslots"
  post "students/update_new_students" => "students#update_new_students"
  get "register/:id" => "registrations#registers"

  post "students/errors" => "students#errors"

resources :events
  resources :activities
  # resources :teams
  # resources :EventsController do
  #   resources :locations
  #   resources :ActivitiesController do
  #     resources :sessions
  #   end
  # end

  get "homeroutes/home" => 'homeroutes#home'
  get 'homeroutes/user/:id' => 'homeroutes#user', as: "profile"
  get "homeroutes/new/:name" => "homeroutes#new"
  post "homeroutes/create" => "homeroutes#create"
  root 'homeroutes#home'
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end

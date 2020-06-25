Rails.application.routes.draw do
  get 'groupings/add'
  devise_for :users, skip: [:devise_registration]
  as :user do
    get 'sign_in', to: 'homeroutes#home'
    get 'sign_up', to: 'homeroutes#home'
  end

  resources :admins
  resources :coordinators
  get "events/index/:role/:id" => "events#index", as: "register_for_activity"
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

  get "/get_locations" => "activities#get_locations"
  get "/get_rooms/:location" => "activities#get_rooms"
  get "/get_session_rooms/:activity" => "activities#get_session_rooms"
  get "register/:role/:session_id/:id" => "registrations#registers"
  get "all_users" => "homeroutes#all_users", as: "all_users"
  post "students/errors" => "students#errors"
  resources :teams
  get "activities/report" => "activities#report", as: "report"
  post "activities/create/:event_id" => "activities#create"
  post "/activities/:id/update" => "activities#update"
  get "/load_activities/:date" => "activities#load_activities", as: "load_report"

  post "events/:id/update" => "events#update"
  post "events/create" => "events#create"
resources :events
  resources :activities

  get "/drop_activity/:role/:session_id/:id" => "registrations#drop_activity"
  get "homeroutes/home" => 'homeroutes#home'
  get 'homeroutes/user/:id' => 'homeroutes#user', as: "profile"
  get "homeroutes/new/:name" => "homeroutes#new", as: "new_user"
  post "homeroutes/create" => "homeroutes#create"
  root 'homeroutes#home'
  post 'homeroutes/reset_password/:id' => "homeroutes#reset_password", as: "reset_password"
  delete "delete_user/:id" => "homeroutes#delete", as: "delete_user"
  get "activity/spreadsheet/:id.xls" => "activities#spread_sheet", as: "activity_spread_sheet"
  get "waitlist/:id/:session_id" => "activities#waitlist", as: "waitlist"
  get "class/registrations/:id" => "homeroutes#class_registrations", as: "class_registrations"
  get "schedule/:id" => "homeroutes#schedule", as: "schedule"
  get "class/attendance/:id" => "homeroutes#class_attendance", as: "attendance"
  get "admin_setup" => "setups#admin_setup", as: "admin_setup"
  post "create_admin" => "setups#create_admin"
  get "new_settings" => "setups#new_settings", as: "new_settings"
  post "save_settings" => "setups#save_settings", as: "save_settings"
  get "edit_settings" => "setups#edit_settings", as: "edit_settings"
  post "update_settings" => "setups#update_settings", as: "update_settings"
  get "default_settings" => "setups#reset_default", as: "default_settings"
  post "events/:id/:change" => "events#change_visibility", as: "event_visibility"
  get "events/new/copy" => "events#copy", as: "copy_event"
  post "events/create_copy" => "events#create_copy", as: "create_copy"
  get "/get_detailed_report/:id" => "activities#detailed_report"
  get "locations/manage" => "locations#manage", as: "manage_locations"
  resources :locations
  delete "delete_room/:id" => "locations#destroy_room", as: "delete_room"
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end

class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_setup, except: [:admin_setup, :create_admin, :new_settings]
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception
  # rubyXL methods
  require 'rubyXL/convenience_methods/worksheet'
  require 'rubyXL/convenience_methods/cell'

  protected

  # first time setup
  def configure_setup
    if Setup.first.nil?
      redirect_to admin_setup_path
    end
  end

  def configure_permitted_parameters
    added_attrs = [:user_name, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end


  def authenticate_user!(opts = {})
    if user_signed_in?
      super
    else
      redirect_to root_path
    end
  end

  def user_not_authorized
    flash[:alert] = 'Access Denied'
    redirect_to (request.referrer || root_path)
  end

  def add_home_breadcrumb
    role = current_user.roles.first.role_name
    id = params[:id] != nil ? params[:id] : nil
    if role != "Student" && role != "Teacher"
      add_breadcrumb "Home", profile_path(current_user)
      if !id.nil? && id.to_i != current_user.id
        add_breadcrumb User.find(id).first_name + "' Profile", profile_path(User.find(id))
      end
    else
      add_breadcrumb "Home", root_path(role: "User", id: current_user.id)
      if !id.nil? && id.to_i != current_user.id || controller_path != "events"
        add_breadcrumb current_user.first_name + "' Profile", profile_path(current_user)
      end
    end
  end
end

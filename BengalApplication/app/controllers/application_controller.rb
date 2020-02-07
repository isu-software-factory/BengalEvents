class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :first_name, :last_name])
  end


  def authenticate_user!(opts={})
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
end

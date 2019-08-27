class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception


  protected

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to root_path
    end
  end

  def user_not_authorized
    flash[:alert] = "Access Denied"
    redirect_to (request.referrer || root_path)
  end


end

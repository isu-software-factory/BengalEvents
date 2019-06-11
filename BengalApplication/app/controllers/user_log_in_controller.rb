class UserLogInController < ApplicationController

  def new
  end

  def create
    # get user from database
    # example:
    #   user = User.find_by(username: params[:username])
    # identify user password
    #   If user && user.authenticate(params[:password])
    #     redirect_to root_url, notice: "Logged In!"
  end


end

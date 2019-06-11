class UserLogInController < ApplicationController
  def index
    # get username and password
    @username = params[:username]
    @password = params[:password]

    # check database here
  end


end

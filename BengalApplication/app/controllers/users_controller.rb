class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    @users = User.all
    authorize User
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update(set_user)
      redirect_to users_path, success: "Updated user"
    else
      redirect_to users_path, alert: "Unable to update user"
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, alert: "User deleted"
  end

  private

  def set_user
    params.require(:user).permit(:role)
  end
end

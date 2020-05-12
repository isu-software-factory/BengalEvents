class SetupsController < ApplicationController
  def admin_setup
    # set configure to true
    Setup.create(configure: true)
    # create user roles
    create_roles
    @user = User.new
  end

  def create_admin
    # create user with admin role
    @user = User.new(get_params)
    if @user.save
      @user.roles << Role.find_by(role_name: "Admin")
      redirect_to site_settings_path
    else
      flash[:errors] = @user.errors.full_messages
      redirect_back(fallback_location: admin_setup_path)
    end
  end

  def site_settings

  end

  private

  def get_params
    params.permit(:first_name, :last_name, :user_name, :email, :password, :password_confirmation)
  end
  def create_roles
    roles = ["Student", "Teacher", "Admin", "Coordinator", "Sponsor"]
    roles.each do |r|
      unless Role.exists?(role_name: r)
        role = Role.new(role_name: r)
        role.save
      end
    end
  end
end

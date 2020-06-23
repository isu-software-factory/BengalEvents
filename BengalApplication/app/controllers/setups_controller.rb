class SetupsController < ApplicationController
  before_action :get_fonts, only: ['new_settings', 'edit_settings']
  before_action :authenticate_user!, except: [:admin_setup, :create_admin]

  def admin_setup
    unless Setup.exists?(id: 1)
      set_settings
    end
    @user = User.new
  end

  def create_admin
    # create user with admin role
    @user = User.new(get_params)
    if @user.save
      @user.roles << Role.find_by(role_name: "Admin")
      sign_in @user
      redirect_to edit_settings_path
    else
      flash[:errors] = @user.errors.full_messages
      redirect_back(fallback_location: admin_setup_path)
    end
  end

  def edit_settings
    @setting = Setting.first
    authorize @setting
    add_home_breadcrumb
    add_breadcrumb "Site Settings", edit_settings_path
  end

  def update_settings
    @setting = Setting.first
    authorize @setting
    if @setting.update(setting_params)
      redirect_to profile_path(current_user)
    else
      redirect_back(fallback_location: edit_settings_path)
    end
  end

  def reset_default
    @setting = Setting.first
    authorize @setting
    @setting.reset_default
    @setting.reset_default_logo
    redirect_to edit_settings_path
  end

  private

  def setting_params
    if params[:logo] == ""
      params.permit(:primary_color, :secondary_color, :font, :additional_color, :site_name)
    else
      params.permit(:primary_color, :secondary_color, :font, :additional_color, :site_name, :logo)
    end
  end


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

  def get_fonts
    @fonts = ["Arial", "Sans-Serif", "Times New Roman", "Times", "Courier", "Verdana", "Georgia", "Palatino", "Bookman", "Comic Sans MS", "Arial Black", "Impact" ]
  end

  def set_settings
    # create settings
    Setting.create()
    Setting.first.reset_default_logo
    # set configure to true
    Setup.create(configure: true)
    # create user roles
    # comment out when testing
    create_roles
  end
end

class SettingPolicy < ApplicationPolicy

  def edit?
    get_role == "Admin"
  end

  def update_settings?
    get_role == "Admin"
  end

  def reset_default?
    get_role == "Admin"
  end

  def reset_password?
    get_role == "Teacher" || get_role == "Admin" || get_role == "Coordinator"
  end

  def edit_settings?
    get_role == "Admin"
  end

  def update_settings?
    get_role == "Admin"
  end
end
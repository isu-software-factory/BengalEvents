class SettingPolicy < ApplicationPolicy
  def get_role
    user.roles.first.role_name
  end

  def edit?
    get_role == "Admin"
  end
end
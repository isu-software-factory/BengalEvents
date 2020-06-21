class ActivityPolicy < ApplicationPolicy

  def new?
    user.roles.first.role_name == "Coordinator" || user.roles.first.role_name == "Admin" || user.roles.first.role_name == "Teacher"
  end

  def reset_password?
    user.roles.first.role_name == "Coordinator" || user.roles.first.role_name == "Admin" || user.roles.first.role_name == "Teacher"
  end

end
class ActivityPolicy < ApplicationPolicy

  def new?
    get_role == "Coordinator" || get_role == "Admin" || get_role == "Teacher"
  end

  def reset_password?
    get_role == "Coordinator" || get_role == "Admin" || get_role == "Teacher"
  end

  def schedule?
    get_role == "Coordinator" || get_role == "Admin" || get_role == "Teacher"
  end
end
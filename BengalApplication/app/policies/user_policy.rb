class UserPolicy < ApplicationPolicy
  def delete?
    get_role == "Admin" || get_role == "Coordinator"
  end

  def new?
    get_role == "Admin" || get_role == "Coordinator" || get_role == "Teacher"
  end

end
class EventPolicy < ApplicationPolicy


  def new?
    user.roles.first.role_name == "Coordinator" || user.roles.first.role_name == "Admin"
  end

  def edit?
    user.roles.first.role_name == "Coordinator" || user.roles.first.role_name == "Admin"
  end

  def update?
    user.roles.first.role_name == "Coordinator" || user.roles.first.role_name == "Admin"
  end

  def create?
    user.roles.first.role_name == "Coordinator" || user.roles.first.role_name == "Admin"
  end

  def show?
    user.roles.first.role_name == "Coordinator" || user.roles.first.role_name == "Admin" || user.roles.first.role_name == "Sponsor"
  end

  def destroy?
    user.roles.first.role_name == "Coordinator" || user.roles.first.role_name == "Admin"
  end
end
class ActivityPolicy < ApplicationPolicy

  def new?
    user.roles.first.role_name == "Coordinator" || user.roles.first.role_name == "Admin" || user.roles.first.role_name == "Sponsor"
  end

  def edit?
    user.roles.first.role_name == "Coordinator" || user.roles.first.role_name == "Admin" || user.roles.first.role_name == "Sponsor"
  end

  def update?
    user.roles.first.role_name == "Coordinator" || user.roles.first.role_name == "Admin" || user.roles.first.role_name == "Sponsor"
  end

  def create?
    user.roles.first.role_name == "Coordinator" || user.roles.first.role_name == "Admin" || user.roles.first.role_name == "Sponsor"
  end

  def show?
    user.roles.first.role_name == "Coordinator" || user.roles.first.role_name == "Admin" || user.roles.first.role_name == "Sponsor"
  end

  def destroy?
    user.roles.first.role_name == "Coordinator" || user.roles.first.role_name == "Admin" || record.user == user
  end

  def report?
    user.roles.first.role_name == "Coordinator" || user.roles.first.role_name == "Admin" || record.user == user
  end
end
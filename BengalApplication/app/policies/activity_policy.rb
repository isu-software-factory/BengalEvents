class ActivityPolicy < ApplicationPolicy

  def new?
    get_role == "Coordinator" || get_role == "Admin" || get_role == "Sponsor"
  end

  def edit?
    get_role == "Coordinator" || get_role == "Admin" || get_role == "Sponsor"
  end

  def update?
    get_role == "Coordinator" || get_role == "Admin" || get_role == "Sponsor"
  end

  def create?
    get_role == "Coordinator" || get_role == "Admin" || get_role == "Sponsor"
  end

  def destroy?
    get_role == "Coordinator" || get_role == "Admin" || record.user == user
  end

  def report?
    get_role == "Coordinator" || get_role == "Admin" || record.user == user
  end
end
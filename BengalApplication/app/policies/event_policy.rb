class EventPolicy < ApplicationPolicy


  def new?
    get_role == "Coordinator" || get_role == "Admin"
  end

  def edit?
    get_role == "Coordinator" || get_role == "Admin"
  end

  def update?
    get_role == "Coordinator" || get_role == "Admin"
  end

  def create?
    get_role == "Coordinator" || get_role == "Admin"
  end

  def show?
    get_role == "Coordinator" || get_role == "Admin" || get_role == "Sponsor"
  end

  def destroy?
    get_role == "Coordinator" || get_role == "Admin"
  end
end
class LocationPolicy < ApplicationPolicy

  def destroy?
    get_role == "Admin" || get_role == "Coordinator"
  end

  def destroy_room?
    get_role == "Admin" || get_role == "Coordinator"
  end
end
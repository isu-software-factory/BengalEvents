class LocationPolicy < ApplicationPolicy

  def new?
    # Only Coordinator can create the Location
    user.meta_type == "Coordinator" || user.meta_type == "Admin"
  end

  def edit?
    # Only Coordinator can edit the Location
    user.meta_type == "Coordinator" || user.meta_type == "Admin"
  end

  def update?
    # Only Coordinator can update the Location
    user.meta_type == "Coordinator" || user.meta_type == "Admin"
  end

  def create?
    # Only Coordinator can create the Location
    user.meta_type == "Coordinator" || user.meta_type == "Admin"
  end

  def show?
    # Only Coordinator can see the Location
    user.meta_type == "Coordinator" || user.meta_type == "Admin"
  end

  def destroy?
    # Only Coordinator can delete the Location
    user.meta_type == "Coordinator"
  end
end
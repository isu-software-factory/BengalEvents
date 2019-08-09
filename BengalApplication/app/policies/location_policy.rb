class LocationPolicy < ApplicationPolicy

  def new?
    user.meta_type == "Coordinator" || user.meta_type == "Admin"
  end

  def edit?
    (user.meta_type == "Coordinator" || user.meta_type == "Admin") && (user.meta.id == record.coordinator.id)
  end

  def update?
    (user.meta_type == "Coordinator" || user.meta_type == "Admin") && (user.meta.id == record.coordinator.id)

  end

  def create?
    user.meta_type == "Coordinator" || user.meta_type == "Admin"
  end

  def show?
    user.meta_type == "Coordinator" || user.meta_type == "Admin" || user.meta_type == "Sponsor"
  end

  def destroy?
    user.meta_type == "Coordinator"
  end
end
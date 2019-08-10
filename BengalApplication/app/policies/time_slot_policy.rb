class TimeSlotPolicy < ApplicationPolicy

  def new?
    # Only Coordinator can create the TimeSlot
    user.meta_type == "Coordinator" || user.meta_type == "Admin"
  end

  def create?
    # Only Coordinator can create the TimeSlot
    user.meta_type == "Coordinator" || user.meta_type == "Admin"
  end

  def destroy?
    # Only Coordinator can destroy the TimeSlot
    user.meta_type == "Coordinator"
  end
end
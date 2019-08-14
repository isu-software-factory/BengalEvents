class EventDetailPolicy < ApplicationPolicy

  def new?
    user.meta_type == "Coordinator"  || user.meta_type == "Sponsor"
  end

  def edit?
    user.meta_type == "Coordinator" || user.meta_type == "Sponsor"
  end

  def update?
    user.meta_type == "Coordinator" || user.meta_type == "Sponsor"
  end

  def create?
    user.meta_type == "Coordinator"  || user.meta_type == "Sponsor"
  end

  def show?
    user.meta_type == "Coordinator"  || user.meta_type == "Sponsor"
  end

  def destroy?
    user.meta_type == "Coordinator" || user.meta_type == "Sponsor"
  end
end
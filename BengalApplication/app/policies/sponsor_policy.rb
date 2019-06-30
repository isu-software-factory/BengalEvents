class SponsorPolicy < ApplicationPolicy
  def show?
    user.present? && user.role == 'sponsor' || user.role == 'admin'
  end

  def destroy?

  end

  def update?
    user.present? && user.role == 'sponsor' || user.role == 'admin'
  end

  def create?
    user.role == 'admin' || user.role == 'coordinator'
  end

  def edit?
    user.present? && user.role == 'sponsor' || user.role == 'admin'
  end

end
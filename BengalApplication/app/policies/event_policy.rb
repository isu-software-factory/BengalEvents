class EventPolicy < ApplicationPolicy

  def create?
    @user.role == "coordinator" || @user.role == "admin"
  end

  def new?
    @user.role == "coordinator"
  end

  def edit?
    @user.role == "coordinator" || @user.role == "admin"
  end

  def update?
    @user.role == "coordinator" || @user.role == "admin"
  end

  def destroy?
    @user.role == "coordinator" || @user.role == "admin"
  end

end
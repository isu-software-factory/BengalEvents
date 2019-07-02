class OccasionPolicy < ApplicationPolicy

  def edit?
    @user.role == "coordinator" || @user.role == "admin"
  end

  def update?
    user.role == "coordinator" || user.role == "admin"
  end

  def create?
    @user.role == "coordinator" || @user.role == "admin"
  end

  def show?
    @user.role == "coordinator" || @user.role == "admin"
  end

  def index?
    @user.role == "coordinator" || @user.role == "admin"
  end

  def destroy?
    @user.coordinator? || @user.role == "admin"
  end
end
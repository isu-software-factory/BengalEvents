class OccasionPolicy < ApplicationPolicy

  def index?
    @user.role == "coordinator" || @user.role == "admin"
  end

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

  def destroy?
    @user.role == "coordinator" || @user.role == "admin"
  end
end
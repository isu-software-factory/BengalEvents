class EventPolicy < ApplicationPolicy

  def create?
    @user.role == "coordinator" || @user.role == "admin" || @user.role == "sponsor"
  end

  def new?
    @user.role == "coordinator" || @user.role == "sponsor" || @user.role == "admin"
  end

  def show?
    @user.role == "coordinator" || @user.role == "sponsor" || @user.role == "admin"
  end

  def edit?
    @user.role == "coordinator" || @user.role == "admin" || @user.role == "sponsor"
  end

  def update?
    @user.role == "coordinator" || @user.role == "admin" || @user.role == "sponsor"
  end

  def destroy?
    @user.role == "coordinator" || @user.role == "admin"
  end

end
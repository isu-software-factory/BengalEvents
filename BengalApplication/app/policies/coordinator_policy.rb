class CoordinatorPolicy < ApplicationPolicy
  def new?
    # only a admin can create a Coordinator
    @user.meta_type == "Admin"
  end

  def show?
    # only Coordinator can see their page
    @user.meta_type == "Coordinator" && @user.meta.id == @record.id
  end

  def destroy?
    @user.meta_type == "Admin"
  end
end
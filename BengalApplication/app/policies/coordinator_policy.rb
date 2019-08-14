class CoordinatorPolicy < ApplicationPolicy

  def show?
    # only Coordinator can see their page
    @user.meta_type == "Coordinator"
  end

  def destroy?
    @user.meta_type == "Admin"
  end
end
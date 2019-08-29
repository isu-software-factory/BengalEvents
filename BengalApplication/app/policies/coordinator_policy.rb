class CoordinatorPolicy < ApplicationPolicy

  def show?
    # only Coordinator can see their page
    @user.meta_type == "Coordinator" && @user.meta.id == @record.id
  end

  def destroy?
    @user.meta_type == "Admin"
  end
end
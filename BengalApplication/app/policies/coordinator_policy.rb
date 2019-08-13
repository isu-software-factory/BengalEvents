class CoordinatorPolicy < ApplicationPolicy

  def new?
    # only a Coordinator can create a student
    @user.meta_type == "Coordinator"
  end

  def create?
    # only a Coordinator can create a student
    @user.meta_type == "Coordinator"
  end

  def show?
    # only Coordinator can see their page
    @user.meta_type == "Coordinator"
  end

  def edit?
    # only Coordinator can edit their details
    @user.meta_type == "Coordinator"
  end

  def update?
    # only Coordinator can update their details
    @user.meta_type == "Coordinator"
  end
  def destroy?
     @user.meta_type == "Admin"
  end
end
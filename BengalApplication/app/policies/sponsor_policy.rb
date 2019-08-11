class SponsorPolicy < ApplicationPolicy

  def new?
    # only a Coordinator can create a student
    @user.meta_type == "Coordinator"
  end

  def create?
    # only a Coordinator can create a student
    @user.meta_type == "Sponsor"
  end

  def show?
    # only Coordinator can see their page
    @user.meta_type == "Sponsor"
  end

  def edit?
    # only Coordinator can edit their details
    @user.meta_type == "Sponsor"
  end

  def update?
    # only Coordinator can update their details
    @user.meta_type == "Sponsor"
  end

  def destroy?
    @user.meta_type == "Admin" || @user.meta_type == "Coordinator"
  end
end
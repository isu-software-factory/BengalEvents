class SponsorPolicy < ApplicationPolicy

  def show?
    @user.meta_type == "Sponsor"
  end


  def destroy?
    @user.meta_type == "Admin" || @user.meta_type == "Coordinator"
  end
end
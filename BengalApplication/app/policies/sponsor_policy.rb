class SponsorPolicy < ApplicationPolicy

  def show?
    @user.meta_type == "Sponsor" && @user.meta.id == @record.id
  end


  def destroy?
    @user.meta_type == "Admin" || @user.meta_type == "Coordinator"
  end
end
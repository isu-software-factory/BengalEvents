class AdminPolicy < ApplicationPolicy

  def show?
    # only Coordinator can see their page
    @user.meta_type == "Admin"
  end

end
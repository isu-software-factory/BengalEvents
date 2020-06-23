class UserPolicy < ApplicationPolicy
  def delete?
    @user.roles.first.role_name == "Admin" || @user.roles.first.role_name == "Coordinator"
  end
end
class TeamPolicy < ApplicationPolicy

  def new?
    # only a student can create a team
    @user.roles.first.role_name == "Student"
  end

  def invite?
    # only a team lead can invite members
   @user.roles.first.role_name == "Student" && record.get_lead == user
  end

  def show?
    # only students can see their team
    @user.roles.first.role_name == "Student" && record.users.include?(user)
  end

  def drop?
    # only a team lead can delete a member
    @user.roles.first.role_name == "Student" && record.get_lead == @user
  end

  def create?
    # only a student can create a team
    @user.roles.first.role_name == "Student"
  end

  def change?
    # only team lead can change team details
    @user.roles.first.role_name == "Student" && record.get_lead == @user
  end
end
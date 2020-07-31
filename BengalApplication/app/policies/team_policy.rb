class TeamPolicy < ApplicationPolicy

  def new?
    # only a student can create a team
    get_role == "Student"
  end

  def invite?
    # only a team lead can invite members
   get_role == "Student" && record.get_lead == user
  end

  def show?
    # only students can see their team
    get_role == "Student" && record.users.include?(user) || get_role == "Admin" || get_role == "Coordinator"
  end

  def drop?
    # only a team lead can delete a member
    get_role == "Student" && record.get_lead == @user
  end

  def create?
    # only a student can create a team
    get_role == "Student"
  end

  def change?
    # only team lead can change team details
    get_role == "Student" && record.get_lead == @user || get_role == "Admin" || get_role == "Coordinator"
  end
end
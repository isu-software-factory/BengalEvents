class TeamPolicy < ApplicationPolicy

  def new?
    # only a student can create a team
    @user.meta_type == "Student"
  end

  def invite?
    # only a team lead can invite members
   @user.meta_type == "Student" && record.lead == user.meta.id
  end

  def show?
    # only students can see their team
    @user.meta_type == "Student" && record.students.include?(user.meta)
  end

  def create?
    # only a student can create a team
    @user.meta_type == "Student"
  end

  def change?
    # only team lead can change team details
    @user.meta_type == "Student" && record.get_lead == @user.meta
  end
end
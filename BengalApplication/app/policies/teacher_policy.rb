class TeacherPolicy < ApplicationPolicy

  def show?
    # only teacher can view teacher page
    @user.meta_type == "Teacher"
  end

  def edit?
    # only a student can create a team
    @user.meta_type == "Teacher"
  end

  def update?
    # only team lead can change team details
    @user.meta_type == "Teacher"
  end

  def destroy?
    # only coordinators or admin can delete a teacher
    @user.meta_type == "Coordinator" || @user.meta_type == "Admin"
  end
end
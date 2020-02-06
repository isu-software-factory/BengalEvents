class TeacherPolicy < ApplicationPolicy

  def show?
    # only teacher can view teacher page
    @user.roles.first.role_name == "Teacher" && @user.id == @record.id || @user.roles.exists?([role_name: "Admin"])
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
    # only coordinators or admins can delete a teacher
    @user.meta_type == "Coordinator" || @user.meta_type == "Admin"
  end
end
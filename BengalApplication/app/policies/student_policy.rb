class StudentPolicy < ApplicationPolicy

  def new?
    # only a teacher can create a student
    @user.meta_type == "Teacher"
  end

  def create?
    # only a teacher can create a student
    @user.meta_type == "Teacher"
  end

  def show?
    # only students can see their page
    @user.meta_type == "Student"
  end

  def edit?
    # only student can edit their details
    @user.meta_type == "Student"
  end

  def update?
    # only student can update their details
    @user.meta_type == "Student"
  end
  def destroy?
    # only team lead can change team details
    @user.meta_type == "Coordinator" || @user.meta_type == "Admin"
  end
end
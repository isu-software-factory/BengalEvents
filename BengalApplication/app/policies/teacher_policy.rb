class TeacherPolicy < ApplicationPolicy
  def show?
    user.present? && user.role == 'teacher' || user.role == 'admin'
  end

  def destroy?

  end

  def update?
    user.present? && user.role == 'teacher' || user.role == 'admin'
  end

  def create?
    user.present? && user.role == 'teacher' || user.role == 'admin'
  end

  def edit?
    user.present? && user.role == 'teacher' || user.role == 'admin'
  end

end
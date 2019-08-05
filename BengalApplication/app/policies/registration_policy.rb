class RegistrationPolicy < ApplicationPolicy

  def register?
    # only teachers, students, and teams can register
    user.meta_type == "Student" || user.meta_type == "Teacher" || record.member_type == "Team"
  end

  def events?
    # only teachers, students, and teams can see registration for events
    user.meta_type == "Student" || user.meta_type == "Teacher" || record.member_type == "Team"
  end

  def index?
    # only teachers, students, and teams can see registration for occasions
    user.meta_type == "Student" || user.meta_type == "Teacher" || record.member_type == "Team"
  end
end

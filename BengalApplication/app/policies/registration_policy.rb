class RegistrationPolicy < ApplicationPolicy

  def register?
    # only teachers, students, and teams can register
    if get_role == "Student"
      record.member_type == "Student" || record.member_type == "Team"
    else
      record.member_type == "Teacher"
    end
  end

  def registers?
    user.id == record.id || get_role == "Teacher" || get_role == "Admin" || get_role == "Coordinator"
  end

  def events?
    # only teachers, students, and teams can see registration for activities
    if get_role == "Student"
      record.member_type == "Student" || record.member_type == "Team"
    else
      record.member_type == "Teacher"
    end
  end

  def index?
    # only teachers, students, and teams can see registration for events
    if get_role == "Student"
      record.member_type == "Student" || record.member_type == "Team"
    else
      record.member_type == "Teacher"
    end
  end

  def drop?
    # only teachers, students, and team leads can drop event details
    if get_role == "Student"
      record.member_type == "Student" || record.member_type == "Team" && user.meta == record.member.get_lead
    else
      record.member_type == "Teacher"
    end
  end
end

class RegistrationPolicy < ApplicationPolicy

  def register?
    # only teachers, students, and teams can register
    if user.meta_type == "Student"
      record.member_type == "Student" || record.member_type == "Team"
    else
      record.member_type == "Teacher"
    end
  end

  def events?
    # only teachers, students, and teams can see registration for events
    if user.meta_type == "Student"
      record.member_type == "Student" || record.member_type == "Team"
    else
      record.member_type == "Teacher"
    end
  end

  def index?
    # only teachers, students, and teams can see registration for occasions
    if user.meta_type == "Student"
      record.member_type == "Student" || record.member_type == "Team"
    else
      record.member_type == "Teacher"
    end
  end

  def drop?
    # only teachers, students, and team leads can drop event details
    if user.meta_type == "Student"
      record.member_type == "Student" || record.member_type == "Team" && user.meta == record.member.get_lead
    else
      record.member_type == "Teacher"
    end
  end
end

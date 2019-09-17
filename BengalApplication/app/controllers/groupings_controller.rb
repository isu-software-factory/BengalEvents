class GroupingsController < ApplicationController
  def add
    # get student and team
    student = Student.find(params[:id])
    team = Team.find(params[:team_id])

    # add student to team
    if team.register_member(student)
      # sign student in and redirect them to team page
      sign_in student.user
      redirect_to team, notice => "You have been added to the team!"
    else
      # student can't register for team
      sign_in student.user
      redirect_to student, notice => "Member limit of 4 reached. No more room for new member"
    end
  end

  def drop
    # drop members from team
    student = Student.find(params[:part_id])
    team = Team.find(params[:id])

    if student == team.get_lead
      authorize team
      team.students.delete(student)
      redirect_to team, notice => "Dropped #{student.name} from team."
    else
      team.students.delete(student)
      redirect_to student, notice => "Left team #{team.name}"
    end
  end
end

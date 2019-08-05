class GroupingsController < ApplicationController
  def add
    # get student and team
    student = Student.find(params[:id])
    team = Team.find(params[:team_id])

    # add student to team
    if team.register_member(student)
      # sign student in and redirect them to team page
      sign_in student.user
      redirect_to team
    else
      # student can't register for team
      flash[:notice] = "Member limit of 4 reached. No more room for new member"
      sign_in student.user
      redirect_to student
    end
  end
end

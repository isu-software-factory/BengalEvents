class GroupingsController < ApplicationController
  def add
    student = Student.find(params[:id])
    team = Team.find(params[:team_id])
    team.students << student
    redirect_to team
  end
end

class GroupingsController < ApplicationController
  def add
    # get student and team
    @student = User.find(params[:id])
    @team = Team.find(params[:team_id])

    # add student to team
    if @team.register_member(@student)
      # sign student in and redirect them to team page
      sign_in @student
      redirect_to @team, :notice => "You have been added to the team!"
    else
      # student can't register for team
      sign_in @student
      redirect_to profile_path(@student),:notice => "Member limit of 4 reached. No more room for new member"
    end
  end

  def drop
    # drop members from team
    @student = User.find(params[:part_id])
    @team = Team.find(params[:id])

    if current_user == @team.get_lead
      authorize @team
      @team.users.delete(@student)
      redirect_to @team, :notice => "Dropped #{@student.first_name} #{@student.last_name} from team."
    else
      @team.users.delete(@student)
      redirect_to profile_path(@student), :notice => "You Have Left Team #{@team.team_name}"
    end
  end
end

class TeamsController < ApplicationController
  before_action :authenticate_user!
  def new
    @team = Team.new
  end
  def create
    @team = Team.new(team_params)
    @student = Student.find(current_user.meta.id)
    if @team.save
      # add team lead

    end
  end

  private
  def team_params
    params.require(:team).permit(:name)
  end
end

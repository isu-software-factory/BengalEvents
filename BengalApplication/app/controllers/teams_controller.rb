class TeamsController < ApplicationController
  before_action :authenticate_user!
  #before_action :get_team, only: [:register_members]
  def register_members
    # get student emails
    # send email to students
    params.each do |email|
      #UserMailer.invite(email)
    end
  end

  def register
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @student = Student.find(current_user.meta.id)
    if @team.save
      # add team lead
      @team.students << @student
      @team.lead = @student.id
      redirect_to @team
    else
      redirect_to @student
    end
  end

  private
  def team_params
    params.require(:team).permit(:lead)
  end

  def get_team
    @team = Team.find(params[:id])
  end

end

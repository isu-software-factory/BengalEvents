class TeamsController < ApplicationController
  before_action :authenticate_user!
  #before_action :get_team, only: [:register_members]
  def register_members
    # get student emails
    # send email to students
    @student = Student.find(current_user.meta.id)
    @pass = true
    emails = [params[:email1], params[:email2], params[:email3], params[:email4]]

    emails.each do |email|
      unless email == ""
        @user = User.find_by(email: email)
        unless @user.nil?
          invited_student = Student.find(@user.meta.id)
          UserMailer.invite(@student, invited_student, @student.participant).deliver_now
        else
          @pass = false
          flash[:notice] = "no such student exits, #{email}"
          render "register"
        end
      end
    end

    redirect_to @student if @pass
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
    @team.lead = @student.id
    Participant.create(member: @team)
    if @team.save
      # add team lead
      @team.students << @student
      redirect_to @team
    else
      redirect_to @student
    end
  end

  private
  def team_params
    params.require(:team).permit(:name)
  end

  def get_team
    @team = Team.find(params[:id])
  end

end

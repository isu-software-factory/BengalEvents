class TeamsController < ApplicationController
  before_action :authenticate_user!
  #before_action :get_team, only: [:register_members]
  def register_members
    # get student emails
    @team = Team.find(params[:id])
    @student = Student.find(current_user.meta.id)
    @pass = true
    emails = [params[:email1], params[:email2], params[:email3], params[:email4]]

    # send emails if students have an account
    emails.each do |email|
      unless email == ""
        @user = User.find_by(email: email)
        unless @user.nil?
          invited_student = Student.find(@user.meta.id)
          UserMailer.invite(@student, invited_student, @team).deliver_now
        else
          @pass = false
          flash[:notice] = "no such student exits, #{email}"
          render "invite"
        end
      end
    end

    # redirect student to student page if emails are sent
    redirect_to @student if @pass
  end

  def invite
    @team = Team.find(params[:id])
    authorize @team
  end

  def show
    @team = Team.find(params[:id])
    authorize @team
  end

  def new
    @team = Team.new
    authorize @team
  end

  def create
    # create team
    @team = Team.new(team_params)
    authorize @team
    @student = Student.find(current_user.meta.id)
    Participant.create(member: @team)
    # add team lead
    @team.lead = @student.id

    if @team.save
      # add lead as member
      @team.students << @student
      redirect_to @team
    else
      redirect_to @student
      flash[:notice] = "Couldn't create a team."
    end
  end

  private
  def team_params
    params.require(:team).permit(:name)
  end
end

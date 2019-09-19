class TeamsController < ApplicationController
  before_action :authenticate_user!

  def register_members
    # get student emails
    @student = Student.find(current_user.meta.id)
    @team = Team.find(params[:id])
    @emails = [params[:email1], params[:email2], params[:email3], params[:email4]]
    # no problems occur?
    @continue = send_emails(@emails, @team)

    # redirect student to student page if emails are sent
    if @continue
      redirect_to @team, :notice => "Invited members to team"
    else
      render 'invite'
    end
  end

  def send_emails(emails, team)
    @pass = true
    # send emails if students have an account
    emails.each do |email|
      unless email == ""
        @user = User.find_by(email: email)
        unless @user.nil?
          invited_student = Student.find(@user.meta.id)
          UserMailer.invite(@student, invited_student, team).deliver_now
        else
          flash[:alert] = "no such student exits, #{email}"
          # error occurs
          @pass = false
        end
      end
    end
    @pass
  end

  def invite
    @team = Team.find(params[:id])
    authorize @team
    add_breadcrumb 'Home', current_user.meta
    add_breadcrumb 'Team', @team
    add_breadcrumb 'Invite Members', ""
  end

  def show
    @team = Team.find(params[:id])
    authorize @team
    add_breadcrumb 'Home', current_user.meta
    add_breadcrumb 'Team', team_path(@team)
  end

  def teamschedulepdf
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
    authorize @team
    add_breadcrumb 'Home', student_path(current_user.meta)
    add_breadcrumb 'Create Team', ""
  end

  def create
    # create team
    @emails = team_emails
    @team = Team.new(team_params)
    authorize @team
    @student = Student.find(current_user.meta.id)
    Participant.create(member: @team)
    # add team lead
    @team.lead = @student.id
    if @team.save
      # add lead as member
      @team.register_member(@student)
      # invite members
      continue = send_emails(@emails, @team)
      if continue
        redirect_to @team
      else
        render 'invite'
      end
    else
      flash[:alert] = @team.errors.full_messages
      render :new
    end
  end

  private

  def get_user
    current_user.meta
  end

  def team_params
    params.require(:team).permit(:name)
  end

  def team_emails
    emails = [params[:email1], params[:email2], params[:email3], params[:email4]]
  end
end

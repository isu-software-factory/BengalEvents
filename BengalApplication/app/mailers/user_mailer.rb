class UserMailer < ApplicationMailer
  # UserMailer.login_email(@user).deliver_now

  def login_email(account, user, password)
    @account = account
    @user = user
    @password = password
    mail(to: @user.email, subject: "Welcome to BengalEvents")
  end

  def invite(account, student, team)
    @account = account
    @team = team
    @student = student
    mail(to: @student.user.email, subject: "Team Invite" )
  end

  def notice(participant, event)
    @participant = participant
    @event = event
    if @participant.member_type == "Team"
      mail(to: @participant.member.get_lead.user.email, subject: "Registration Notice")
    else
      mail(to: @participant.member.user.email, subject: "Registration Notice")
    end

  end

  def event_notice(participant, event)
    @participant = participant
    @event = event

    if @participant.member_type == "Team"
      mail(to: @participant.member.get_lead.user.email, subject: "Event Notice")
    else
      mail(to: @participant.member.user.email, subject: "Event Notice")
    end
  end
end

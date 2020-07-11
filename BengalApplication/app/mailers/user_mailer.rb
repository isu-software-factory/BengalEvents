class UserMailer < ApplicationMailer
  default from: "isuevent@isu.edu"


  def login_email(user, password)
    @user = user
    @password = password
    mail(to: @user.email, subject: "Welcome to BengalEvents")
  end



  def notice(user, activity)
    @user = user
    @activity = activity
    if @activity.iscompetetion
      mail(to: @user.get_lead.email, subject: "Registration Notice")
    else
      mail(to: @user.email, subject: "Registration Notice")
    end
  end

  def reset_password(teacher, student, password)
    @teacher = teacher
    @student = student
    @password = password
    mail(to: @teacher.email, subject: @student.first_name + "'s new password")
  end
end

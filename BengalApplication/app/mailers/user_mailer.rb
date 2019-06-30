class UserMailer < ApplicationMailer
  # UserMailer.welcome_email(@user).deliver_now

  def login_email(user, link)
    @user = user
    @link = link
    mail(to: @user.email, subject: "Welcome to BengalEvents")
  end

end

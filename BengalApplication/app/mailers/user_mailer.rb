class UserMailer < ApplicationMailer
  # UserMailer.login_email(@user).deliver_now

  def login_email(account, user, password)
    @account = account
    @user = user
    @password = password
    mail(to: @user.email, subject: "Welcome to BengalEvents")
  end

end

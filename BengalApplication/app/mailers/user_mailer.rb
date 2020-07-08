class UserMailer < ApplicationMailer
  default from: "isuevent@isu.edu"

  def reset_password(teacher, student, password)
    @teacher = teacher
    @student = student
    @password = password
    mail(to: @teacher.email, subject: @student.first_name + "'s new password")
  end
end

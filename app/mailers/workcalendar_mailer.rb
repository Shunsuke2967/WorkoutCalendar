class WorkcalendarMailer < ApplicationMailer
  def user_create_email(user,password)
    @password = password
    @user = user
    mail(
      subject: "サインアップ完了のメール",
      to: "#{@user.email}"
    )
  end
end

class UserMailer < ApplicationMailer
  # default from: "from@example.com"

  def registration_confirmation(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to My Awesome Site!")
  end

end

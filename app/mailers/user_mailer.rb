class UserMailer < ApplicationMailer

  default from: "PatrickSaysHi@epicodus.fun"

  def signup_confirmation(user)
    @user = user

    mail to: user.email, subject: "Sign Up Confirmation"
  end
end

# Preview all emails at http://localhost:3000/rails/mailers/user
class UserPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user/signup_confirmation
  def signup_confirmation
    UserMailer.signup_confirmation
  end

end

class ApplicationMailer < ActionMailer::Base
  default from: "piensaque.com@gmail.com"

  def welcome_mail(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

end

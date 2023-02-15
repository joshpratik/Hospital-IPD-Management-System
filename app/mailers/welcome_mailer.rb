class WelcomeMailer < ApplicationMailer

  def welcome_mail(password)
    @user = params[:user]
    @password = password
    @url  = 'http://localhost:3000/login'
    mail(to: 'pratikbaravkar5@gmail.com', subject: 'Welcome OnBoard')
  end
end

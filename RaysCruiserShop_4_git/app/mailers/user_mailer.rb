class UserMailer < ActionMailer::Base
  default from: "no-reply@rays-cruiser.com", css: 'compiled/email'
#   layout 'email'
#   helper :application

  # Send new user welcome email.
  def welcome_email(user)
    @user = user
    @subject = "Welcome to Rays Cruiser, home of customized cruisers"
    result = mail(:to => @user.email, :subject => @subject)
    # puts "+++++++ Notification Email status: -> " + result.to_s
  end
end
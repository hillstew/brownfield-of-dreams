# app/mailers/registration_mailer.rb
class RegistrationMailer < ApplicationMailer
  def activate(user)
    @user = user
    mail(to: user.email, subject: 'Visit here to activate your account')
  end
end

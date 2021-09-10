class UserMailer < Devise::Mailer
  default from: 'community-connector@yopmail.com'

  def confirmation_email(user)
    @user = user
    mail(
      from: 'community-connector@yopmail.com',
      to: @user.email,
      subject: 'Please confirm your account at Community Connector',
    )
  end
end

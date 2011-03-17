class Mailer < ActionMailer::Base
  default :from => 'no-reply@sendgrid.com',
          :subject => 'Test email'

  def email_with_multiple_recipients(recipients)
    add_recipients recipients
    mail :body => "Hello!"
  end
end


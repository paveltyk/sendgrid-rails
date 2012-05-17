class Mailer < ActionMailer::Base
  default :from => 'no-reply@sendgrid.com',
          :subject => 'Test email'

  def email_with_multiple_recipients(recipients)
    mail :to => recipients, :body => "Hello!"
  end

  def email_open_tracking(opentrack_enabled = true)
    open_tracking opentrack_enabled
    mail :to => 'email@email.com', :body => 'Hello!'
  end

  def email_standard_smtp(enabled = false)
    standard_smtp enabled
    mail :to => 'email@email.com', :body => 'Hello!'
  end

end


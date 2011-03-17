require 'send_grid'
autoload :ActionMailer, 'action_mailer'

ActionMailer::Base.send :include, SendGrid


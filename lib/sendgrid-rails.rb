require 'send_grid'
require 'active_support'
require 'active_support/core_ext'
autoload :ActionMailer, 'action_mailer'

ActionMailer::Base.send :include, SendGrid


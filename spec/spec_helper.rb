require 'sendgrid-rails'

ActionMailer::Base.register_interceptor(SendGrid::MailInterceptor)
ActionMailer::Base.delivery_method = :test
ActionMailer::Base.prepend_view_path File.join(File.dirname(__FILE__), "fixtures", "views")

Dir["#{File.dirname(__FILE__)}/fixtures/mailers/*.rb"].each { |f| require f }

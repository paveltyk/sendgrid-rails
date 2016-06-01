# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "send_grid/version"

Gem::Specification.new do |s|
  s.name        = "sendgrid-rails"
  s.version     = SendGrid::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["PavelTyk"]
  s.email       = ["paveltyk@gmail.com"]
  s.homepage    = "https://github.com/PavelTyk/sendgrid-rails"
  s.license     = "MIT"
  s.summary     = %q{SendGrid gem fo Rails 3}
  s.description = %q{Gem to extend ActionMailer with SendGrid API support}

  s.rubyforge_project = "sendgrid-rails"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.required_ruby_version = '>= 2.0.0'
  s.add_development_dependency "rspec", "~> 2.5.0"
  s.add_dependency "actionmailer", ">= 3.0.0"
  s.add_dependency "activesupport", ">= 2.1.0"
end


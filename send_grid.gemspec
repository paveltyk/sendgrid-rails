# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "send_grid/version"

Gem::Specification.new do |s|
  s.name        = "sendgrid-rails"
  s.version     = SendGrid::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["PavelTyk"]
  s.email       = ["paveltyk@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{SendGrid Rails gem}
  s.description = %q{Easy to use SendGrid API gem}

  s.rubyforge_project = "sendgrid-rails"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_development_dependency "rspec", "~> 2.5.0"
  s.add_dependency "actionmailer", ">= 3.0.0"
  s.add_dependency "activesupport", ">= 2.1.0"
end


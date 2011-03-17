require 'spec_helper'

describe Mailer do
  describe 'email with multiple recipients' do
    let(:recipients) { %w(email1@email.com email2@email.com) }
    let(:mail) { Mailer.email_with_multiple_recipients recipients }

    it 'set correct recipients in X-SMTAPI header' do
      mail.to_s.should include('X-SMTPAPI: {"to":["email1@email.com","email2@email.com"]}')
    end

    # Send Grid will ignore this attr any way, but ActionMailer will raise error
    # if :to attr is blank
    it 'set default :to header if it was nil' do
      ActionMailer::Base.smtp_settings = { :domain => 'sendgrid.com' }
      mail.to.should eq ['group-delivery@sendgrid.com']
    end
  end

  describe '#open_tracking' do

    it 'set correct open tracking enabled X-SMTAPI header' do
      Mailer.email_open_tracking.to_s.should include('X-SMTPAPI: {"filters":{"opentrack":{"settings":{"enabled":1}}}}')
    end

    it 'set correct open tracking disabled X-SMTAPI header' do
      Mailer.email_open_tracking(false).to_s.should include('X-SMTPAPI: {"filters":{"opentrack":{"settings":{"enabled":0}}}}')
    end

    it 'set correct open tracking nil X-SMTAPI header' do
      Mailer.email_open_tracking(nil).to_s.should_not include('X-SMTPAPI: {"filters":{"opentrack')
    end
  end
end


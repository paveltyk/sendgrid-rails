require 'spec_helper'

describe Mailer do
  describe 'email with multiple recipients' do
    it 'set correct recipients in X-SMTAPI header' do
      Mailer.email_with_multiple_recipients(%w(em1@email.com em2@email.com)).deliver.header.to_s.
        should include('X-SMTPAPI: {"to":[ "em1@email.com", "em2@email.com" ]}')

      Mailer.email_with_cc_recipients(%w(em1@email.com), %w(cc@email.com), %w(bcc@email.com)).deliver.header.to_s.
        should include('X-SMTPAPI: {"to":[ "em1@email.com", "cc@email.com", "bcc@email.com" ]}')
    end

    it 'removes original TO header part' do
      Mailer.email_with_multiple_recipients(%w(em1@email.com em2@email.com)).deliver.header.to_s.
        should_not include("To: em1@email.com")
    end

    it 'maintains recommended header line length' do
      emails = 15.times.map{ |i| "email#{i}@example.com" }
      header = Mailer.email_with_multiple_recipients(emails).deliver.header.to_s
      header.lines.each do |line|
        unless line.starts_with?('Message-ID:') # May be longer depending on your test machine
          line.should have_at_most(72).characters
        end
      end
    end
  end

  describe '#open_tracking' do
    it 'set correct open tracking enabled X-SMTAPI header' do
      Mailer.email_open_tracking.deliver.header.to_s.
        should include('"filters":{"opentrack":{"settings":{"enabled":1}}}')
    end

    it 'set correct open tracking disabled X-SMTAPI header' do
      Mailer.email_open_tracking(false).deliver.header.to_s.
        should include('"filters":{"opentrack":{"settings":{"enabled":0}}}')
    end

    it 'set correct open tracking nil X-SMTAPI header' do
      Mailer.email_open_tracking(nil).deliver.header.to_s.
        should_not include('"filters":{"opentrack')
    end
  end

  describe 'dummy_recipient used in TO is taken from config' do
    it 'should be used in TO default dummy_recipient' do
      # by defaut dummy_recipient's email is dummy@email.com

      Mailer.email_with_multiple_recipients(%w(em1@email.com em2@email.com)).deliver.header.to_s.
        should include('To: dummy@email.com')
    end

    it 'should be used in To defined in config dummy_recipient' do
      # dummy_recipient can be redefined config/initializers

      SendGrid.configure do |config|
        config.dummy_recipient = 'noreply@example.com'
      end

      Mailer.email_with_multiple_recipients(%w(em1@email.com em2@email.com)).deliver.header.to_s.
        should include('To: noreply@example.com')
    end
  end
end

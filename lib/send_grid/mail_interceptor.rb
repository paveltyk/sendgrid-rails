module SendGrid
  class MailInterceptor
    def self.delivering_email(mail)
      sendgrid_header = mail.instance_variable_get(:@sendgrid_header)
      sendgrid_header.add_recipients(mail.to)
      sendgrid_header.add_recipients(mail.cc)
      sendgrid_header.add_recipients(mail.bcc)
      mail.header['X-SMTPAPI'] = sendgrid_header.to_json if sendgrid_header.data.present?
      mail.header['to'] = SendGrid.config.dummy_recipient
    end
  end
end

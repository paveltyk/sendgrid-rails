module SendGrid
  class MailInterceptor
    def self.delivering_email(mail)
      sendgrid_header = mail.instance_variable_get(:@sendgrid_header)
      mail.header['X-SMTPAPI'] = sendgrid_header.to_json if sendgrid_header.data.present?
    end
  end
end

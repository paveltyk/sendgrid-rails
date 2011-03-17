module SendGrid
  autoload :ApiHeader, 'send_grid/api_header'
  autoload :VERSION, 'send_grid/version'

  def self.included(base)
    base.class_eval do
      include InstanceMethods
      delegate :add_recipients, :substitute, :uniq_args, :category, :add_filter_setting, :to => :send_grid_header
      alias_method_chain :mail, :send_grid
    end
  end

  module InstanceMethods
    def send_grid_header
      @send_grid_header ||= SendGrid::ApiHeader.new
    end

    def send_grid_stub_for_recipient_email
      smtp_domain = self.class.smtp_settings[:domain]
      self.class.smtp_settings[:user_name] || "group-delivery@#{smtp_domain}"
    end

    def mail_with_send_grid(headers={}, &block)
      headers[:to] ||= send_grid_stub_for_recipient_email
      headers['X-SMTPAPI'] = send_grid_header.to_json if send_grid_header.data.present?
      mail_without_send_grid(headers, &block)
    end

    def open_tracking(enabled = true)
      add_filter_setting(:opentrack, :enabled, enabled ? 1 : 0) unless enabled.nil?
    end
  end
end


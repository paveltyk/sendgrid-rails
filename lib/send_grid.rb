module SendGrid
  autoload :ApiHeader, 'send_grid/api_header'
  autoload :MailInterceptor, 'send_grid/mail_interceptor'
  autoload :VERSION, 'send_grid/version'
  autoload :Config, 'send_grid/config'

  def self.included(base)
    base.class_eval do
      prepend InstanceMethods
      delegate :substitute, :uniq_args, :category, :add_filter_setting, :deliver_at, :template_id, :to => :sendgrid_header
      alias_method :sendgrid_header, :send_grid_header
    end
  end


  module InstanceMethods
    def send_grid_header
      @send_grid_header ||= SendGrid::ApiHeader.new
    end

    def mail(headers={}, &block)
      super(headers, &block).tap do |message|
        message.instance_variable_set :@sendgrid_header, sendgrid_header
      end
    end

    def open_tracking(enabled = true)
      add_filter_setting(:opentrack, :enabled, enabled ? 1 : 0) unless enabled.nil?
    end
  end

  class << self
    attr_writer :config

    def config
      @config ||= SendGrid::Config.new
    end

    # Sendgrid.config will be default if block is not passed
    def configure
      yield(self.config) if block_given?
    end
  end
end

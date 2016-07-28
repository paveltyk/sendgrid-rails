class SendGrid::Config
  attr_accessor :dummy_recipient

  def initialize
    @dummy_recipient = "dummy@example.com"
  end
end

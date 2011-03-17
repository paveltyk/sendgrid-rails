require 'spec_helper'

describe 'SendGrid::VERSION' do
  it "returns string" do
    SendGrid::VERSION.should be_an_instance_of(String)
  end
end


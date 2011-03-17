class SendGrid::ApiHeader
  attr_reader :data

  def initialize
    @data = {}
  end

  def add_recipients(recipients)
    @data[:to] ||= []
    @data[:to] |= Array.wrap(recipients)
  end

  def substitute(var, val)
    @data[:sub] ||= {}
    @data[:sub][var] = Array.wrap(val)
  end

  def uniq_args(val)
    @data[:unique_args] = val if val.instance_of?(Hash)
  end

  def category(cat)
    @data[:category] = cat
  end

  def add_filter_setting(fltr, setting, val)
    @data[:filters] ||= {}
    @data[:filters][fltr] ||= {}
    @data[:filters][fltr][:settings] ||= {}
    @data[:filters][fltr][:settings][setting] = val
  end

  def to_json
    @data.to_json
  end
end


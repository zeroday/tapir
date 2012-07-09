class NetSvc
  #belongs_to  :host
  #has_many    :web_apps
  #has_many    :task_runs
  #after_save   :log

  include ModelHelper

  key :fingerprint, String
  key :proto, String
  key :port_num, Integer
  key :created_at, Time
  key :updated_at, Time

  def to_s
    "#{self.class}: #{proto}/#{port_num} #{fingerprint}"
  end

  def capitalize 
    "NetService"
  end

private
  def log
    TapirLogger.instance.log self.to_s
  end

end

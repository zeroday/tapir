class NetSvc
  #belongs_to  :host
  #has_many    :web_apps
  #has_many    :task_runs
  #after_save   :log

  include Mongoid::Document
  include ModelHelper

  field :name, type: String
  field :status, type: String
  field :confidence, type: Integer  
  field :fingerprint, type: String
  field :proto, type: String
  field :port_num, type: Integer
  field :created_at, type: Time
  field :updated_at, type: Time

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

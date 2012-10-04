class NetSvc
  #belongs_to  :host
  #has_many    :web_apps
  #has_many    :task_runs

  include Mongoid::Document
  include EntityHelper

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

end

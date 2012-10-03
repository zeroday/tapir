class WebApp
  #belongs_to :net_svc
  #has_many    :web_forms
  #has_many    :task_runs

  #after_save :log
  
  include Mongoid::Document
  include ModelHelper

  field :name, type: String
  field :status, type: String
  field :confidence, type: Integer  
  field :url, type: String
  field :fingerprint, type: String
  field :description, type: String
  field :technology, type: String
  field :created_at, type: Time
  field :updated_at, type: Time

  def to_s
    "#{self.class}: #{self.name} -  #{self.url}"
  end

private
  def log
    TapirLogger.instance.log self.to_s
  end
end

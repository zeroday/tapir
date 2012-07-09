class WebApp < ActiveRecord::Base
  #belongs_to :net_svc
  #has_many    :web_forms
  #has_many    :task_runs

  after_save :log
  
  include ModelHelper

  key :url, String
  key :fingerprint, String
  key :description, String
  key :technology, String
  key :created_at, Time
  key :updated_at, Time

  def to_s
    "#{self.class}: #{self.name} -  #{self.url}"
  end

private
  def log
    TapirLogger.instance.log self.to_s
  end
end

class WebForm < ActiveRecord::Base
  #belongs_to :web_app
  #has_many    :task_runs
  #after_save :log

  include ModelHelper

  key :metric, Integer
  key :url, String
  key :action, String
  key :fields, String

  def to_s
    "#{self.class}: #{self.name} - #{self.url} -> #{self.action}"
  end

private
  def log
    TapirLogger.instance.log self.to_s
  end
end

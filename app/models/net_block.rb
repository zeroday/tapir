class NetBlock < ActiveRecord::Base
  after_save   :log
  has_many    :task_runs
  
  include ModelHelper

  def to_s
    "#{self.class}: #{self.range}"
  end
  
  def capitalize 
    "NetBlock"
  end

private

  def log
    EarLogger.instance.log self.to_s
  end
  
end

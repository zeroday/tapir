class NetBlock < ActiveRecord::Base
  after_save   :log
  has_many    :task_runs
  validates_uniqueness_of :range
  validates_presence_of   :range
  
  include ModelHelper

  def to_s
    "#{self.class}: #{self.range}"
  end
  
  def capitalize 
    "NetBlock"
  end

private

  def log
    TapirLogger.instance.log self.to_s
  end
  
end

class NetBlock
  #has_many    :task_runs
  #validates_uniqueness_of :range
  #validates_presence_of   :range
  after_save   :log

  include ModelHelper

  key :range, String 
  key :handle, String
  key :description, String
  key :created_at, Time
  key :updated_at, Time

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

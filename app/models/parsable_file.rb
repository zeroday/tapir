
class ParsableFile
  #after_save :log
  #validates_presence_of :path
  #validates_uniqueness_of :path
  #has_many :task_runs
  
  include ModelHelper

  key :path, String
  key :type, String
  key :created_at, Time
  key :updated_at, Time


  def to_s
    "#{self.class}: #{name} (#{path})"
  end

private
  def log
    TapirLogger.instance.log self.to_s
  end
end

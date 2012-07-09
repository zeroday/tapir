class Image
  #has_many     :task_runs
  #has_many     :physical_locations
  after_save   :log

  include ModelHelper

  key :local_path, String
  key :remote_path, String
  key :description, String
  key :created_at, Time
  key :updated_at, Time
  
  def to_s
    "#{self.class}: #{self.id}"
  end

  def filename
    self.local_path.split(File::SEPARATOR).last
  end

private

  def log
    TapirLogger.instance.log self.to_s
  end

end

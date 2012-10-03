class Image
  #has_many     :task_runs
  #has_many     :physical_locations
  #after_save   :log

  include Mongoid::Document
  include ModelHelper


  field :name, type: String
  field :status, type: String
  field :confidence, type: Integer  
  field :local_path, type: String
  field :remote_path, type: String
  field :description, type: String
  field :created_at, type: Time
  field :updated_at, type: Time
  
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

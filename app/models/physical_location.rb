class PhysicalLocation
  #belongs_to    :organization
  #has_many      :task_runs
  after_save    :log

  include ModelHelper

  key :address, String
  key :city, String
  key :state, String
  key :country, String
  key :zip, String
  key :latitude, String
  key :longitude, String
  key :created_at, Time
  key :updated_at, Time
  
  def to_s
    "#{self.class}: #{address} #{city} #{state} #{country} (#{latitude} #{longitude})"
  end
  

private
  def log
    TapirLogger.instance.log self.to_s
  end

end

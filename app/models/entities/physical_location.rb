class PhysicalLocation
  #belongs_to    :organization
  #has_many      :task_runs
  #after_save    :log

  include Mongoid::Document
  include EntityHelper

  field :name, type: String
  field :status, type: String
  field :confidence, type: Integer  
  field :address, type: String
  field :city, type: String
  field :state, type: String
  field :country, type: String
  field :zip, type: String
  field :latitude, type: String
  field :longitude, type: String
  field :created_at, type: Time
  field :updated_at, type: Time
  
  def to_s
    "#{self.class}: #{address} #{city} #{state} #{country} (#{latitude} #{longitude})"
  end
  

private
  def log
    TapirLogger.instance.log self.to_s
  end

end

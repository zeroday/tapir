class NetBlock
  #has_many    :task_runs
  #validates_uniqueness_of :range
  #validates_presence_of   :range
  #after_save   :log

  include Mongoid::Document
  include EntityHelper

  field :name, type: String
  field :status, type: String
  field :confidence, type: Integer  
  field :range, type: String 
  field :handle, type: String
  field :description, type: String
  field :created_at, type: Time
  field :updated_at, type: Time

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

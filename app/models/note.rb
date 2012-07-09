class Note
  #validates_presence_of :name
  after_save   :log
  include ModelHelper
  
  key :description
  key :created_at, Time
  key :updated_at, Time

  def to_s
    "#{self.class}: #{self.name}"
  end

private
  def log
    TapirLogger.instance.log self.to_s
  end
end

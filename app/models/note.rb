class Note
  #validates_presence_of :name
  #after_save   :log
  include Mongoid::Document
  include ModelHelper
  
  field :name, type: String
  field :status, type: String
  field :confidence, type: Integer  
  field :description, type: String
  field :created_at, type: Time
  field :updated_at, type: Time

  def to_s
    "#{self.class}: #{self.name}"
  end

private
  def log
    TapirLogger.instance.log self.to_s
  end
end

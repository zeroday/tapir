class Note < ActiveRecord::Base
  validates_presence_of :name
  after_save   :log
  include ModelHelper
  
  def to_s
    "#{self.class}: #{self.name}"
  end

private
  def log
    TapirLogger.instance.log self.to_s
  end
end

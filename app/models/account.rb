class Account < ActiveRecord::Base
  belongs_to  :user
  after_save :log
  validates_presence_of   :name, :service
  validates_uniqueness_of :name, :scope => :service

  include ModelHelper

  def to_s
    "#{self.class}: #{name} (#{service})"
  end

private
  def log
    EarLogger.instance.log self.to_s
  end
  
end

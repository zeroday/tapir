class Account < ActiveRecord::Base
  belongs_to  :user
  after_save :log
  validates_presence_of   :account_name, :service_name, :uri
  validates_uniqueness_of :account_name, :scope => :service_name

  include ModelHelper

  def to_s
    "#{self.class}: #{account_name} (#{service_name} / #{uri})"
  end

private
  def log
    EarLogger.instance.log self.to_s
  end
  
end

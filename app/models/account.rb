class Account
  #belongs_to  :user
  #validates_presence_of   :account_name, :service_name, :check_uri
  #validates_uniqueness_of :account_name, :scope => :service_name
  
  after_save :log

  include ModelHelper

  key :account_name, String
  key :service_name, String
  key :web_uri, String
  key :check_uri, String
  key :user_id, Integer
  key :created_at, Time
  key :updated_at, Time 

  def to_s
    "#{self.class}: #{account_name} (#{service_name})"
  end

private

  def log
    TapirLogger.instance.log self.to_s
  end
  
end

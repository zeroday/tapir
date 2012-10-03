class Account
  #belongs_to  :user
  #validates_presence_of   :account_name, :service_name, :check_uri
  #validates_uniqueness_of :account_name, :scope => :service_name
  
  #after_save :log

  include Mongoid::Document
  include ModelHelper

  field :name, type: String
  field :status, type: String
  field :confidence, type: Integer  
  field :account_name, type: String
  field :service_name, type: String
  field :web_uri, type: String
  field :check_uri, type: String
  field :user_id, type: Integer
  field :created_at, type: Time
  field :updated_at, type: Time 

  def to_s
    "#{self.class}: #{account_name} (#{service_name})"
  end

private

  def log
    TapirLogger.instance.log self.to_s
  end
  
end

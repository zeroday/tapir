class Username
  #belongs_to  :user
  #validates_presence_of   :account_name, :service_name, :check_uri
  #validates_uniqueness_of :account_name, :scope => :service_name

  include Mongoid::Document
  include EntityHelper

  field :name, type: String
  field :status, type: String
  field :confidence, type: Integer
  field :created_at, type: Time
  field :updated_at, type: Time 

  def to_s
    "#{self.class}: #{account_name} (#{service_name})"
  end
end

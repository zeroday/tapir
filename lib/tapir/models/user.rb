module Tapir
class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Multitenancy::Document

  tenant(:tenant)
  
  field :username, type: String
  field :email, type: String

  has_many :settings
  
end
end
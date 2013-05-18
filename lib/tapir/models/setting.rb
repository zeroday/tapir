module Tapir
class Setting
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Multitenancy::Document

  tenant(:tenant)

  has_one :user

  field :name, type: String
  field :value, type: String
  field :visibility, type: String

  validates_uniqueness_of :name

end
end
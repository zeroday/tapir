module Tapir
class Project
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Multitenancy::Document

  tenant(:tenant)

  field :name, type: String

end
end
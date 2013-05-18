module Tapir
  module Entities
    class Finding < Base
      field :content, type: String
      field :details, type: String

      tenant(:tenant)    

      validates_uniqueness_of :content
    end
  end
end
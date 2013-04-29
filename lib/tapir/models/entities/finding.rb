module Tapir
  module Entities
    class Finding < Base
      field :content, type: String
      field :created_at, type: Time
      field :updated_at, type: Time
    
    end
  end
end
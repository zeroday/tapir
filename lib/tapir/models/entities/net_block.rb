module Tapir
  module Entities
    class NetBlock < Base
      field :range, type: String 
      field :handle, type: String
      field :description, type: String
      field :created_at, type: Time
      field :updated_at, type: Time
    end
  end
end
module Tapir
  module Entities
    class Username < Base
      field :created_at, type: Time
      field :updated_at, type: Time 

    end
  end
end
module Tapir
  module Entities
    class SearchString < Base
      field :description, type: String
      field :created_at, type: Time
      field :updated_at, type: Time

    end
  end
end
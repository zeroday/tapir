module Tapir
  module Entities
    class SearchString < Base
      field :description, type: String

      tenant(:tenant)

    end
  end
end
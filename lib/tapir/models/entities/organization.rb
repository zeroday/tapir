module Tapir
  module Entities
    class Organization < Base
      field :description, type: String

      tenant(:tenant)

    end
  end
end
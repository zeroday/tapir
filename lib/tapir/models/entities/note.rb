module Tapir
  module Entities
    class Note < Base
      field :description, type: String

      tenant(:tenant)

    end
  end
end
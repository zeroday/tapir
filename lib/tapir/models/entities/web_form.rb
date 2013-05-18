module Tapir
  module Entities
    class WebForm < Base
      field :url, type: String
      field :action, type: String
      field :fields, type: String

      tenant(:tenant)

    end
  end
end
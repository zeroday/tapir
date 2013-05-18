module Tapir
  module Entities
    class WebApp < Base
      field :url, type: String
      field :fingerprint, type: String
      field :description, type: String
      field :technology, type: String

      tenant(:tenant)

    end
  end
end
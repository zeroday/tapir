module Tapir
  module Entities
    class WebApp < Base
      field :url, type: String
      field :fingerprint, type: String
      field :description, type: String
      field :technology, type: String
      field :created_at, type: Time
      field :updated_at, type: Time


    end
  end
end
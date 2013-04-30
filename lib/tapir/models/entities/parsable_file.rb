module Tapir
  module Entities
    class ParsableFile < Base
      field :path, type: String
      field :type, type: String
      field :created_at, type: Time
      field :updated_at, type: Time

    end
  end
end
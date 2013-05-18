module Tapir
  module Entities
    class ParsableFile < Base
      field :path, type: String
      field :type, type: String

    end
  end
end
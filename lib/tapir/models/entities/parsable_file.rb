module Tapir
  module Entities
    class ParsableFile < Base
      #after_save :log
      #validates_presence_of :path
      #validates_uniqueness_of :path
      

      field :path, type: String
      field :type, type: String
      field :created_at, type: Time
      field :updated_at, type: Time

    end
  end
end
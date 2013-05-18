module Tapir
  module Entities
    class PhysicalLocation < Base
      field :address, type: String
      field :city, type: String
      field :state, type: String
      field :country, type: String
      field :zip, type: String
      field :latitude, type: String
      field :longitude, type: String
      
      tenant(:tenant)

      def to_s
         super << " #{latitude}/#{longitude}"
      end

    end
  end
end
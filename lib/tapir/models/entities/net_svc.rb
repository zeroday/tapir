module Tapir
  module Entities
    class NetSvc < Base
      field :fingerprint, type: String
      field :proto, type: String
      field :port_num, type: Integer
      field :created_at, type: Time
      field :updated_at, type: Time

      def to_s
         super << " #{port_num}/#{proto}"
      end

    end
  end
end
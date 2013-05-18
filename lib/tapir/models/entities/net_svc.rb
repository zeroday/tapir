module Tapir
  module Entities
    class NetSvc < Base
      field :fingerprint, type: String
      field :proto, type: String
      field :port_num, type: Integer

      has_one :host

      tenant(:tenant)

      def to_s
         super << " #{port_num}/#{proto}"
      end

    end
  end
end
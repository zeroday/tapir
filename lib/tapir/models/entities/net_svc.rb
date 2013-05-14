module Tapir
  module Entities
    class NetSvc < Base
      field :fingerprint, type: String
      field :proto, type: String
      field :port_num, type: Integer
      field :created_at, type: Time
      field :updated_at, type: Time

      #belongs_to :host
      #validates_uniqueness_of :proto, :port_num, :scope => [:host_id]

      embedded_in :host

      def to_s
         super << " #{host.name}:#{port_num}/#{proto}"
      end

    end
  end
end
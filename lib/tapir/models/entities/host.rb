module Tapir
  module Entities
    class Host < Base
      field :ip_address, type: String
      field :created_at, type: Time
      field :updated_at, type: Time

      #
      # This method is highly questionable, but folks generally refer to a host
      # by its ip address(es), and thus, this makes tasks easier to code.
      #
      def name
        ip_address
      end

    end
  end
end
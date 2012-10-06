module Tapir
  module Entities
    class Host < Base
      #as_many     :net_svcs
      #has_many     :domains
      #has_many     :physical_locations
      #has_many     :task_runs
      #validates_uniqueness_of :ip_address
      #validates_presence_of   :ip_address
      #validates_format_of :ip_address, :with => /^(\d+)\.(\d+)\.(\d+)\.(\d+)$/

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
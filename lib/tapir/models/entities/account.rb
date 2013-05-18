module Tapir
  module Entities
    class Account < Base
      field :account_name, type: String
      field :service_name, type: String
      field :web_uri, type: String
      field :check_uri, type: String

      tenant(:tenant)

      def to_s
        super << " #{service_name} #{account_name}"
      end

      def name
        "#{account_name}"
      end

    end
  end
end
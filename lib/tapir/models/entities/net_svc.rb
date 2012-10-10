module Tapir
  module Entities
    class NetSvc < Base
      #belongs_to  :host
      #has_many    :web_apps
      #has_many    :task_runs

      field :fingerprint, type: String
      field :proto, type: String
      field :port_num, type: Integer
      field :created_at, type: Time
      field :updated_at, type: Time

      def capitalize 
        "Tapir::Entities::NetSvc"
      end

      def underscore
        "tapir_entities_net_svc"
      end

    end
  end
end
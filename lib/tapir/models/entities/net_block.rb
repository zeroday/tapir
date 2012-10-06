module Tapir
  module Entities
    class NetBlock < Base
      #has_many    :task_runs
      #validates_uniqueness_of :range
      #validates_presence_of   :range
      #after_save   :log

      field :range, type: String 
      field :handle, type: String
      field :description, type: String
      field :created_at, type: Time
      field :updated_at, type: Time
      
      def capitalize 
        "Tapir::Entities::NetBlock"
      end


    end
  end
end
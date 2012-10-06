module Tapir
  module Entities
    class Username < Base
      #belongs_to  :user
      #validates_presence_of   :account_name, :service_name, :check_uri
      #validates_uniqueness_of :account_name, :scope => :service_name

      field :created_at, type: Time
      field :updated_at, type: Time 

    end
  end
end
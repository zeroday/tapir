module Tapir
  module Entities
    class Account < Base
      #belongs_to  :user
      #validates_presence_of   :account_name, :service_name, :check_uri
      #validates_uniqueness_of :account_name, :scope => :service_name

      field :account_name, type: String
      field :service_name, type: String
      field :web_uri, type: String
      field :check_uri, type: String
      #field :user_id, type: Integer
      field :created_at, type: Time
      field :updated_at, type: Time 
        
    end
  end
end
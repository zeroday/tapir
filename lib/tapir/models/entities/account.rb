module Tapir
  module Entities
    class Account < Base
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
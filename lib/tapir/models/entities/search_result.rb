module Tapir
  module Entities
    class SearchResult < Base
      field :link, type: String
      field :url, type: String
      field :content, type: String  
      field :created_at, type: Time
      field :updated_at, type: Time
    end
  end
end
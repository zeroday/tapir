module Tapir
  module Entities
    class SearchResult < Base
      field :link, type: String
      field :url, type: String
      field :content, type: String 

      tenant(:tenant)
       
    end
  end
end
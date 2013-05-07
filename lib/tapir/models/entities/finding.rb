module Tapir
  module Entities
    class Finding < Base
      field :content, type: String
      field :details, type: String
    
      def to_s
        super << " #{content}"
      end

    end
  end
end
module Tapir
  module Entities
    class Image < Base
      field :local_path, type: String
      field :remote_path, type: String
      field :description, type: String

      tenant(:tenant)

      def filename
        self.local_path.split(File::SEPARATOR).last
      end

      def to_s
        super << " #{remote_path}" 
      end

    end
  end
end

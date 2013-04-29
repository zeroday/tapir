module Tapir
  module Entities
    class Image < Base
      field :local_path, type: String
      field :remote_path, type: String
      field :description, type: String
      field :created_at, type: Time
      field :updated_at, type: Time

      def filename
        self.local_path.split(File::SEPARATOR).last
      end

    end
  end
end

module Tapir
  module Entities
    class Image < Base
      #has_many     :task_runs
      #has_many     :physical_locations

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

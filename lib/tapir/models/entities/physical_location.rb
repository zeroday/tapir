module Tapir
  module Entities
    class PhysicalLocation < Base
      #belongs_to    :organization
      #has_many      :task_runs

      field :address, type: String
      field :city, type: String
      field :state, type: String
      field :country, type: String
      field :zip, type: String
      field :latitude, type: String
      field :longitude, type: String
      field :created_at, type: Time
      field :updated_at, type: Time

    end
  end
end
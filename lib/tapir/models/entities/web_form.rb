module Tapir
  module Entities
    class WebForm < Base
      #belongs_to :web_app
      #has_many    :task_runs

      field :url, type: String
      field :action, type: String
      field :fields, type: String
      field :created_at, type: Time
      field :updated_at, type: Time

    end
  end
end
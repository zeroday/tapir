module Tapir
  module Entities
    class WebApp < Base
      #belongs_to :net_svc
      #has_many    :web_forms
      #has_many    :task_runs

      #after_save :log

      field :url, type: String
      field :fingerprint, type: String
      field :description, type: String
      field :technology, type: String
      field :created_at, type: Time
      field :updated_at, type: Time

    end
  end
end
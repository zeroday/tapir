class TaskRunSet
  #has_many :task_runs

  include Mongoid::Document

  field :created_at, type: Time
  field :updated_at, type: Time
end

class TaskRunSet < ActiveRecord::Base
  #has_many :task_runs

  key :created_at, Time
  key :updated_at, Time
end

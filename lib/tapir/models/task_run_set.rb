module Tapir
class TaskRunSet

  include Mongoid::Document

  field :created_at, type: Time
  field :updated_at, type: Time

  def task_runs
    TaskRun.where(:task_run_set_id => self.id)
  end

end
end
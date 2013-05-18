module Tapir
class TaskRunSet

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Multitenancy::Document

  tenant(:tenant)

  def task_runs
    TaskRun.where(:task_run_set_id => self.id)
  end

end
end
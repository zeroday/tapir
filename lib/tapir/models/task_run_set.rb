module Tapir
class TaskRunSet
  #has_many :task_runs

  include Mongoid::Document

  field :created_at, type: Time
  field :updated_at, type: Time

  def task_runs
    #binding.pry
    TaskRun.where(:task_run_set_id => self.id)
  end

end
end
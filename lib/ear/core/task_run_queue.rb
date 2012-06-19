class RunnableTaskQueue
  include Enumerable
  def add_task_run(object, task, options)
    x = task.execute(object,options)
  x
  end

end

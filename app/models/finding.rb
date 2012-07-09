class Finding
  #has_many     :task_runs
  after_save   :log

  include ModelHelper

  key :content, String
  key :created_at, Time
  key :updated_at, Time

  def to_s
    "#{self.class}"
  end

private
  def log
    TapirLogger.instance.log self.to_s
  end
end

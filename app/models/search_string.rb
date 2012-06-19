class SearchString < ActiveRecord::Base
  has_many     :task_runs
  
  after_save   :log

  include ModelHelper

  def to_s
    "#{self.class}: #{self.name}"
  end

private
  def log
    TapirLogger.instance.log self.to_s
  end

end

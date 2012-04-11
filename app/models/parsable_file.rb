
class ParsableFile < ActiveRecord::Base
  after_save :log
  validates_presence_of :path
  validates_uniqueness_of :path
  has_many :task_runs
  
  include ModelHelper

  def to_s
    "#{self.class}: #{name} (#{path})"
  end

private
  def log
    EarLogger.instance.log self.to_s
  end
end

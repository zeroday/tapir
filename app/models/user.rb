class User < ActiveRecord::Base
  belongs_to  :organization
  has_many    :physical_locations
  has_many    :task_runs
  has_many    :accounts

  validates_presence_of :usernames
  
  serialize :usernames
  
  before_save :uniq_usernames
  after_save :log
  after_create :set_usernames_empty

  include ModelHelper

  def to_s
    "#{self.class}: #{self.first_name} #{self.last_name}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

private
  def set_usernames_empty
    self.usernames.uniq!
    self.save!
  end

  def uniq_usernames
    self.usernames.uniq!
  end

  def log
    EarLogger.instance.log self.to_s
  end

end

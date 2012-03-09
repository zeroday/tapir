class TaskRun < ActiveRecord::Base
  belongs_to :organization
  belongs_to :user
  belongs_to :physical_address
  belongs_to :domain
  belongs_to :host
  belongs_to :net_svc
  belongs_to :web_app
  belongs_to :web_form
  has_many :object_mappings
  
  def to_s
    "#{task_name} task -> #{task_object_type}:#{task_object_id} (#{object_mappings.count})"
  end
end

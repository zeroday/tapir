class TaskRun
  #belongs_to :task_run_set
  #belongs_to :account
  #belongs_to :domain
  #belongs_to :finding
  #belongs_to :host
  #belongs_to :net_block
  #belongs_to :net_svc
  #belongs_to :note
  #belongs_to :organization
  #belongs_to :parsable_file
  #belongs_to :physical_address
  #belongs_to :search_string
  #belongs_to :user
  #belongs_to :web_app
  #belongs_to :web_form
  #has_many :entity_mappings

  include Mongoid::Document

  many :entity_mappings

  field :task_name, type: String
  field :task_entity_id, type: Integer
  field :task_entity_type, type: String
  field :task_options_hash, type: String
  field :task_log, type: String

  def to_s
    "#{task_name} task -> #{task_entity_type}:#{task_entity_id} (#{entity_mappings.count})"
  end
end

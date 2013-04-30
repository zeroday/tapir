module Tapir
class TaskRun
  include Mongoid::Document

  field :task_name, type: String
  field :task_run_set_id, type: String
  field :task_entity_id, type: String
  field :task_entity_type, type: String
  field :task_options_hash, type: String
  field :task_log, type: String

  def to_s
    "#{task_name} task -> #{task_entity_type}:#{task_entity_id}"
  end

  def entity_mappings
    EntityMapping.all_of(
      {"$and" => [{:child_id => self.task_entity_id},
        {:child_type => self.task_entity_type}]}, 
      {"$and" => [{:parent_id => self.task_entity_id},
        {:parent_type => self.task_entity_type}]})
  end

end
end
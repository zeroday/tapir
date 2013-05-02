module Tapir
class EntityMapping
  include Mongoid::Document

  belongs_to :task_run

  field :child_id, type: String
  field :child_type, type: String
  field :parent_id, type: String
  field :parent_type, type: String
  field :task_run_id, type: String
  field :created_at, type: Time
  field :updated_at, type: Time

  def get_child
    TapirLogger.instance.log "Trying to find #{child_type}:#{child_id}"
    
    #begin
      eval "#{child_type}.find(\"#{child_id}\")"
    #rescue ActiveRecord::RecordNotFound => e
    #  TapirLogger.instance.log "Oops, couldn't find #{child_type}:#{child_id}"
    #  nil
    #end
    
  end
  
  def get_parent
    TapirLogger.instance.log "Trying to find #{parent_type}:#{parent_id}"
    
    begin
      eval "#{parent_type}.find #{parent_id}"
    rescue ActiveRecord::RecordNotFound => e
      TapirLogger.instance.log "Oops, couldn't find #{child_type}:#{child_id}"
      nil
    end
  end

  def to_s
    "#{self.class}: #{child_type}:#{child_id} <-> #{parent_type}:#{parent_id} - (task_run: #{task_run.id})"
  end 

end
end
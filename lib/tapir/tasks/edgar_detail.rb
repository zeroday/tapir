# Returns the name of this task.
def name
  "edgar_detail"
end

# Returns a string which describes this task.
def description
  "This task hits the corpwatch API and adds detail for the organization."
end

# Returns an array of valid types for this task
def allowed_types
  [Tapir::Entities::Organization]
end

## Returns an array of valid options and their description/type for this task
def allowed_options
 []
end

def setup(entity, options={})
  super(entity, options)
  self
end

# Default method, subclasses must override this
def run
  super

  x = Tapir::Client::Corpwatch::CorpwatchService.new
  corps = x.search @entity.name

  # Attach to the first entity
  @entity.physical_locations << create_entity(Tapir::Entities::PhysicalLocation, {
    :address => corps.first.address, 
    :state => corps.first.state, 
    :country => corps.first.country })

  # Save off our raw data
  #@task_run.save_raw_result corps.join(" ")

end

def cleanup
  super
end

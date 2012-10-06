# Returns the name of this task.
def name
  "google_hostname_search"
end

# Returns a string which describes this task.
def description
  "This task hits the Google API and creates an entity for all discovered hostnames."
end

# Returns an array of valid types for this task
def allowed_types
  [ Tapir::Entities::SearchString, 
    Tapir::Entities::Organization, 
    Tapir::Entities::Domain]
end

def setup(entity, options={})
  super(entity, options)
  self
end

# Default method, subclasses must override this
def run
  super

  x = Tapir::Client::Google::SearchService.new
  results = x.search @entity.name

  results.each do |result|
    o = create_entity Domain, { :name => result.visible_url }
  end
end

def cleanup
  super
end

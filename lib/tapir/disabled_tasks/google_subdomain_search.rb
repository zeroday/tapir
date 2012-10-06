# Returns the name of this task.
def name
  "google_subdomain_search"
end

# Returns a string which describes this task.
def description
  "This task hits the Google API and creates an entity for all discovered subdomains."
end

# Returns an array of valid types for this task
def allowed_types
  [ Tapir::Entities::Domain]
end

def setup(entity, options={})
  super(entity, options)
  self
end

# Default method, subclasses must override this
def run
  super

  # Attach to the google search service
  x = Tapir::Client::Google::SearchService.new

  # Use the inurl: capability
  results = x.search "inurl:.#{@entity.name}"

  results.each do |result|
    # Create a new domain
    o = create_entity Domain, { :name => result.visible_url, 
      :organization => @entity.organization }
  end

end

def cleanup
  super
end

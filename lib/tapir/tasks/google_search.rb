# Returns the name of this task.
def name
  "google_search"
end

def pretty_name
  "Google Search"
end

# Returns a string which describes this task.
def description
  "This task hits the Google API and finds related domains."
end

# Returns an array of valid types for this task
def allowed_types
  [ Tapir::Entities::SearchString, 
    Tapir::Entities::Organization, 
    Tapir::Entities::Domain, 
    Tapir::Entities::Host,
    Tapir::Entities::User, 
    Tapir::Entities::Username, 
    Tapir::Entities::Account]
end

def setup(entity, options={})
  super(entity, options)
  self
end

# Default method, subclasses must override this
def run
  super

  # Attach to the corpwatch service & search
  results = Tapir::Client::Google::SearchService.new.search(@entity.name)

  results.each do |result|
    create_entity Tapir::Entities::Domain, :name => result[:visible_url]
    create_entity Tapir::Entities::SearchResult, {
      :name => result[:title_no_formatting],
      :url => result[:unescaped_url],
      :content => result[:content]
    }
  end

end

def cleanup
  super
end

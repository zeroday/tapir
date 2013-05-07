# Returns the name of this task.
def name
  "google_dork_search"
end

# Returns a string which describes this task.
def description
  "This task hits the Google API and searches for common googledorks."
end

# Returns an array of valid types for this task
def allowed_types
  [ Tapir::Entities::SearchString, 
    Tapir::Entities::Organization, 
    Tapir::Entities::Domain, 
    Tapir::Entities::Host]
end

def setup(entity, options={})
  super(entity, options)
  self
end

# Default method, subclasses must override this
def run
  super

  # Attach to the corpwatch service & search
  x = Tapir::Client::Google::SearchScraper.new
  
  dork_strings = ["filetype:xls","filetype:doc", "filetype:asp"]
  
  dork_strings.each do |dork|

    # do the actual search - dependent on the type
    if @entity.kind_of?(Organization)
      results = x.search "#{dork} inurl:#{@entity.name}"
    elsif @entity.kind_of?(Domain)
      results = x.search "#{dork} site:#{@entity.name}"
    else
      results = x.search "#{dork}"
    end

    results.each do |result|
      
      # Add the host 
      
      # add the webapp
      
      # add the webform? - if there's a form
      
      # need someway to represent a page? 
      
      #or vulnerability

    end
  end

end

def cleanup
  super
end

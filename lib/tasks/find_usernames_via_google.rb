def name
  "find_usernames_via_google"
end

## Returns a string which describes what this task does
def description
  "This task looks for usernames via google searchs."
end

## Returns an array of types that are allowed to call this task
def allowed_types
  [User]
end

def setup(object, options={})
  super(object, options)
end

## Default method, subclasses must override this
def run
  super
  
  #
  # Do the google search
  #
  results = GSearchParser.webSearch(@object.name.gsub(" ","%20"))
  
  results.each do |r|
    #
    # Parse the results for known patterns  
    #
    
    # Check to see if this is a twitter result&
    # grab the username if so
    if r.title =~ /on Twitter/
      
      @task_logger.log "Found a twitter account! (#{r.title}"
      account_name = r.title.gsub(/<.?em>/,"").split("@").last.split(")").first
      
      @task_logger.log_good "Storing a twitter account! (#{account_name})"
      @object.usernames  << account_name
      
      @object.save
    end

    # TODO - we can do the same thing with the linkedin URL, but we'll need to tweak
    # gsearch-parser in order to get it out

  end
  
  end

def cleanup
  super
end

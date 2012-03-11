def name
  "profile_search"
end

## Returns a string which describes what this task does
def description
  "This task searches for common social media profiles"
end

## Returns an array of types that are allowed to call this task
def allowed_types
  [SearchString, User]
end

def setup(object, options={})
  super(object, options)
end

## Default method, subclasses must override this
def run
  super
  
  if @object.kind_of? User
    account_name = @object.username
  else
    account_name = @object.name
  end
  
  ###
  ### Twitter
  ###
  
  # Check for a twitter account
  account_uri = "http://www.twitter.com/#{account_name}"
  begin
    doc = Nokogiri::HTML(open(account_uri, "User-Agent" => EAR::USER_AGENT_STRING))

    # Add the account if we don't get an error
    unless doc.to_s.include? "Sorry, that page doesn’t exist!"
      @task_logger.log "Found an account at: #{account_uri}"
      obj = create_object Account, :name => account_name, :service => "twitter"
    end
    # If we passed in a user, associate that with our new account object
    if @object.kind_of? User
      obj.user_id = @object.id
      obj.save
    end

  rescue OpenURI::HTTPError => e 
    @task_logger.log "Error, couldn't open #{account_uri}"
  end

  ###
  ### FourSquare
  ###

  # Check for a foursquare account
  account_uri = "https://foursquare.com/#{account_name}"
  begin
    doc = Nokogiri::HTML(open(account_uri, "User-Agent" => EAR::USER_AGENT_STRING))

    # Add the account if we don't get an error
    unless doc.to_s.include? "We couldn't find the page you're looking for."
      @task_logger.log "Found an account at: #{account_uri}"
      obj = create_object Account, :name => account_name, :service => "foursquare"
    end

    # If we passed in a user, associate that with our new account object
    if @object.kind_of? User
      obj.user_id = @object.id
      obj.save
    end

  rescue OpenURI::HTTPError => e 
    @task_logger.log "Error, couldn't open #{account_uri}"
  end
  

  ###
  ### Soundcloud
  ###

  # Check for a soundcloud account
  account_uri = "http://m.soundcloud.com/#{account_name}"

  begin
    doc = Nokogiri::HTML(open(account_uri, "User-Agent" => EAR::USER_AGENT_STRING))

    # Add the account if we don't get an error
    unless doc.to_s.include? "Oops, looks like we can't find that page!"
      @task_logger.log "Found an account at: #{account_uri}"
      obj = create_object Account, :name => account_name, :service => "soundcloud"
    end

    # If we passed in a user, associate that with our new account object
    if @object.kind_of? User
      obj.user_id = @object.id
      obj.save
    end

  rescue OpenURI::HTTPError => e 
    @task_logger.log "Error, couldn't open #{account_uri}"
  rescue RuntimeError => e
    @task_logger.log "Redirection? #{e}"
  end

  ###
  ### Google+
  ###
  
  # this looks a little more difficult (no direct username access)
  
end

def cleanup
  super
end

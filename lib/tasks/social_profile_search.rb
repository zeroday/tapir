def name
  "social_profile_search"
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
  
  #
  # Store the account name, depending on the object we passed in.
  #
  if @object.kind_of? User
    account_names = @object.usernames || ["#{@object.first_name}_#{@object.last_name}"]
  else
    account_names = [@object.name]
  end
  
  #
  # Iterate through all account names!
  #
  account_names.each do |account_name|

    @task_logger.log "Looking for account name: #{account_name}"
    
    ###
    ### Facebook
    ###
    facebook_client = Ear::Client::Facebook::WebClient.new
    if facebook_client.check_account_exists(account_name)
      @task_logger.log "Found an account at: #{facebook_client.account_uri_for(account_name)}"
      obj = create_object Account, :account_name => account_name, 
      :service_name => "facebook", 
      :uri => facebook_client.account_uri_for(account_name)
      #
      # If we passed in a user, associate that with our new account object
      #
      if @object.kind_of? User
        obj.user_id = @object.id
        obj.save!
      end
    else 
      @task_logger.log "No account found at: #{facebook_client.account_uri_for(account_name)}"
    end
    
    ###
    ### FourSquare
    ###
    foursquare_client = Ear::Client::FourSquare::WebClient.new
    if foursquare_client.check_account_exists(account_name)
      @task_logger.log "Found an account at: #{foursquare_client.account_uri_for(account_name)}"
      obj = create_object Account, :account_name => account_name, 
      :service_name => "foursquare", 
      :uri => foursquare_client.account_uri_for(account_name)
      #
      # If we passed in a user, associate that with our new account object
      #
      if @object.kind_of? User
        obj.user_id = @object.id
        obj.save!
      end
    else 
      @task_logger.log "No account found at: #{foursquare_client.account_uri_for(account_name)}"
    end
      
    ###
    ### Myspace
    ###
    myspace_client = Ear::Client::Myspace::WebClient.new
    if myspace_client.check_account_exists(account_name)
      @task_logger.log "Found an account at: #{myspace_client.account_uri_for(account_name)}"
      obj = create_object Account, :account_name => account_name, 
        :service_name => "myspace" , 
        :uri => myspace_client.account_uri_for(account_name)
      #
      # If we passed in a user, associate that with our new account object
      #
      if @object.kind_of? User
        obj.user_id = @object.id
        obj.save!
      end
    else 
      @task_logger.log "No account found at: #{myspace_client.account_uri_for(account_name)}"
    end 
    
    ###
    ### Soundcloud
    ###
    soundcloud_client = Ear::Client::SoundCloud::WebClient.new
    if soundcloud_client.check_account_exists(account_name)
      @task_logger.log "Found an account at: #{soundcloud_client.account_uri_for(account_name)}"
      obj = create_object Account, :account_name => account_name, 
        :service_name => "soundcloud", 
        :uri => soundcloud_client.account_uri_for(account_name)
      #
      # If we passed in a user, associate that with our new account object
      #
      if @object.kind_of? User
        obj.user_id = @object.id
        obj.save!
      end
    else 
      @task_logger.log "No account found at: #{soundcloud_client.account_uri_for(account_name)}"
    end
    
    ###
    ### TwitPic
    ###
    twitpic_client = Ear::Client::TwitPic::WebClient.new
    if twitpic_client.check_account_exists(account_name)
      @task_logger.log "Found an account at: #{twitpic_client.account_uri_for(account_name)}"
      obj = create_object Account, :account_name => account_name, 
      :service_name => "twitpic", 
      :uri => twitpic_client.account_uri_for(account_name)
      #
      # If we passed in a user, associate that with our new account object
      #
      if @object.kind_of? User
        obj.user_id = @object.id
        obj.save!
      end
    else 
      @task_logger.log "No account found at: #{twitpic_client.account_uri_for(account_name)}"
    end
    
    ###
    ### Twitter
    ###
    twitter_client = Ear::Client::Twitter::WebClient.new
    if twitter_client.check_account_exists(account_name)
      @task_logger.log "Found an account at: #{twitter_client.account_uri_for(account_name)}"
      obj = create_object Account, :account_name => account_name, 
      :service_name => "twitter", 
      :uri => twitter_client.account_uri_for(account_name)
      #
      # If we passed in a user, associate that with our new account object
      #
      if @object.kind_of? User
        obj.user_id = @object.id
        obj.save!
      end
    else 
      @task_logger.log "No account found at: #{twitter_client.account_uri_for(account_name)}"
    end
    
    ###
    ### Google+
    ###
    google_client = Ear::Client::Google::WebClient.new
    if google_client.check_account_exists(account_name)
      @task_logger.log "Found an account at: #{google_client.account_uri_for(account_name)}"
      obj = create_object Account, :account_name => account_name, 
        :service_name => "google" , 
        :uri => google_client.account_uri_for(account_name)
      #
      # If we passed in a user, associate that with our new account object
      #
      if @object.kind_of? User
        obj.user_id = @object.id
        obj.save!
      end
    else 
      @task_logger.log "No account found at: #{google_client.account_uri_for(account_name)}"
    end
  end
end

def cleanup
  super
end

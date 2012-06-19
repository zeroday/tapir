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
    ### Loop through services, creating a client & checking
    ###
    ["Facebook", "FourSquare", "LinkedIn", "Google", "Myspace", 
    "SoundCloud", "TwitPic", "Twitter",  "YFrog" ].each do |client_name|
      
      #
      # Create a client of the current type
      # 
      client = eval("Tapir::Client::#{client_name}::WebClient.new")
      if client.check_account_exists(account_name)
        @task_logger.log "Found an account at: #{client.check_account_uri_for(account_name)}"
        
        #
        # Create an account w/ the correct parameters
        #
        obj = create_object Account, 
        :account_name => account_name, 
        :service_name => client.service_name, 
        :check_uri => client.check_account_uri_for(account_name),
        :web_uri => client.web_account_uri_for(account_name)

        #
        # If we passed in a user, associate that with our new account object
        #
        if @object.kind_of? User
          obj.user_id = @object.id
          obj.save!
        end
      else 
        @task_logger.log "No #{client.service_name} account found at: #{client.check_account_uri_for(account_name)}"
      end
    end
    
  end
end

def cleanup
  super
end

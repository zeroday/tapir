def name
  "whois"
end

## Returns a string which describes what this task does
def description
  "Whois lookup"
end

## Returns an array of valid types for this task
def allowed_types
  [Host, Domain]
end

def setup(object, options={})
  super(object, options)
end

def run
  super

  #
  # Set up & make the query
  #
  begin 
    whois = Whois::Client.new(:timeout => 20)
    answer = whois.query @object.name 
  rescue Whois::Error => e
    @task_logger.log "Unable to query whois: #{e}"
  rescue StandardError => e
    @task_logger.log "Unable to query whois: #{e}"
  rescue Exception => e
    @task_logger.log "UNKNOWN EXCEPTION! Unable to query whois: #{e}"
  end

  #
  # Check first to see if we got an answer back
  #
  if answer
    
    #
    # if it was a domain, we've got a whole lot of shit we can scoop
    #
    if @object.kind_of? Domain
      #
      # We're going to have nameservers either way?
      #
      if answer.nameservers
        answer.nameservers.each do |nameserver|
          #
          # If it's an ip address, let's create a host record
          #
          if nameserver.to_s =~ /\d\.\d\.\d\.\d/
            new_object = create_object Host , :ip_address => nameserver.to_s
          else
            #
            # Otherwise it's another domain, and we can't do much but add it
            #
            new_object = create_object Domain, :name => nameserver.to_s
          end
        end
      end
      #
      # Set the record properties
      #
      @object.disclaimer = answer.disclaimer
#      @object.domain = answer.domain
      @object.referral_whois = answer.referral_whois
      @object.status = answer.status
      @object.registered = answer.registered?
      @object.available = answer.available?
      @object.registrar_name = answer.registrar.name
      @object.registrar_org = answer.registrar.organization
      @object.registrar_url = answer.registrar.url
      @object.record_created_on = answer.created_on
      @object.record_updated_on = answer.updated_on
      @object.record_expires_on = answer.expires_on
      
      #
      # Create a user from the technical contact
      #
      begin
        if answer.technical_contact
          @task_logger.log "Creating user from technical contact"
          fname,lname = answer.technical_contact.name.split(" ")
          create_object(User, {:first_name => fname, :last_name => lname})
        end
      rescue Exception => e 
        @task_logger.log "Unable to grab technical contact" 
     end

      #
      # Create a user from the admin contact
      #
      begin
        if answer.admin_contact
          @task_logger.log "Creating user from admin contact"
          fname,lname = answer.admin_contact.name.split(" ")
          create_object(User, {:first_name => fname, :last_name => lname})
        end
      rescue Exception => e 
        @task_logger.log "Unable to grab admin contact" 
     end

      #
      # Create a user from the registrant contact
      #
      begin
        if answer.registrant_contact
          @task_logger.log "Creating user from registrant contact"
          fname,lname = answer.registrant_contact.name.split(" ")
          create_object(User, {:first_name => fname, :last_name => lname})
        end
      rescue Exception => e 
        @task_logger.log "Unable to grab registrant contact" 
     end

    @object.save!

    #
    # Otherwise our object must've been a host
    #
    else 
      #
      # Parse out the netrange - WARNING SUPERGHETTONESS ABOUND
      #
      doc = Nokogiri::XML(open ("http://whois.arin.net/rest/ip/#{@object.ip_address}"))
      start_address = doc.xpath("//xmlns:net/xmlns:startAddress").text
      end_address = doc.xpath("//xmlns:net/xmlns:endAddress").text
      handle = doc.xpath("//xmlns:net/xmlns:handle").text
      org_ref = doc.xpath("//xmlns:net/xmlns:orgRef").text
      #
      #
      #
      create_object NetBlock, {
        :range => "#{start_address}-#{end_address}",
        :handle => handle, 
        :description => org_ref
        }
    end

  else
    @task_logger.log "Domain WHOIS failed, we don't know what nameserver to query."
  end
  
end

def cleanup
  super
end

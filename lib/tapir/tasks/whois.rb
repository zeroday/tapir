def name
  "whois"
end

def pretty_name
  "WHOIS Lookup"
end

## Returns a string which describes what this task does
def description
  "Perform a whois lookup for a given entity"
end

## Returns an array of valid types for this task
def allowed_types
  [ Tapir::Entities::Host, 
    Tapir::Entities::Domain]
end

## Returns an array of valid options and their description/type for this task
def allowed_options
 [{:timeout => {:description => "Timeout for the query", :type => Integer }}]
end

def setup(entity, options={})
  super(entity, options)
end

def run
  super

  #
  # Set up & make the query
  #
  begin 
    whois = Whois::Client.new(:timeout => 20)
    answer = whois.lookup @entity.name 
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
    if @entity.kind_of? Tapir::Entities::Domain
      #
      # We're going to have nameservers either way?
      #
      if answer.nameservers
        answer.nameservers.each do |nameserver|
          #
          # If it's an ip address, let's create a host record
          #
          if nameserver.to_s =~ /\d\.\d\.\d\.\d/
            new_entity = create_entity Tapir::Entities::Host , :ip_address => nameserver.to_s
          else
            #
            # Otherwise it's another domain, and we can't do much but add it
            #
            new_entity = create_entity Tapir::Entities::Domain, :name => nameserver.to_s
          end
        end
      end
      #
      # Set the record properties
      #
      @entity.disclaimer = answer.disclaimer
#      @entity.domain = answer.domain
      #@entity.referral_whois = answer.referral_whois
      @entity.status = answer.status
      @entity.registered = answer.registered?
      @entity.available = answer.available?
      if answer.registrar
        @entity.registrar_name = answer.registrar.name
        @entity.registrar_org = answer.registrar.organization
        @entity.registrar_url = answer.registrar.url
      end
      @entity.record_created_on = answer.created_on
      @entity.record_updated_on = answer.updated_on
      @entity.record_expires_on = answer.expires_on
      
      #
      # Create a user from the technical contact
      #
      begin
        if answer.technical_contact
          @task_logger.log "Creating user from technical contact"
          fname,lname = answer.technical_contact.name.split(" ")
          create_entity(User, {:first_name => fname, :last_name => lname})
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
          create_entity(Tapir::Entities::User, {:first_name => fname, :last_name => lname})
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
          create_entity(Tapir::Entities::User, {:first_name => fname, :last_name => lname})
        end
      rescue Exception => e 
        @task_logger.log "Unable to grab registrant contact" 
     end

    @entity.save!

    #
    # Otherwise our entity must've been a host
    #
    else 
      #
      # Parse out the netrange - WARNING SUPERGHETTONESS ABOUND
      #
      doc = Nokogiri::XML(open ("http://whois.arin.net/rest/ip/#{@entity.ip_address}"))
      start_address = doc.xpath("//xmlns:net/xmlns:startAddress").text
      end_address = doc.xpath("//xmlns:net/xmlns:endAddress").text
      handle = doc.xpath("//xmlns:net/xmlns:handle").text
      org_ref = doc.xpath("//xmlns:net/xmlns:orgRef").text
      #
      #
      #
      create_entity Tapir::Entities::NetBlock, {
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

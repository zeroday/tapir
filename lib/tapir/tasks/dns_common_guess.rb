require 'dnsruby'

def name
  "dns_common_guess"
end

## Returns a string which describes what this task does
def description
  "Guess some common domain names based on the organization name"
end

## Returns an array of valid types for this task
def allowed_types
  [Tapir::Entities::Organization]
end

## Returns an array of valid options and their description/type for this task
def allowed_options
 []
end

def setup(entity, options={})
  super(entity, options)
end

def run
  super

  @task_logger.log "Running DNS name guess on #{@entity}"

  guess_name = @entity.name.gsub(" ", "")

  domains = ["#{guess_name}.com", "#{guess_name}.net", "#{guess_name}.org"]

  # For each of the suggested domains
  domains.each do |domain|
    begin
      res_answer = Resolv.new.getaddress(domain)
      if res_answer
        @task_logger.log_good "DNS Guess succeeded for #{res_answer}"

        # We know the domain is ~valid, and the ip address too
        d = create_entity(Domain, :name => domain)
        h = create_entity(Host, :ip_address => res_answer)

    end
    rescue Dnsruby::Refused
      @task_logger.log "Lookup for #{guess_name} refused."
    rescue Dnsruby::ResolvError
      @task_logger.log "Unable to resolve #{guess_name}"
    rescue Dnsruby::ResolvTimeout
      @task_logger.log "Timed out while querying #{guess_name}."
    rescue Exception => e
      @task_logger.log "Unknown exception: #{e}"
    end
  end
end

def cleanup
  super
end

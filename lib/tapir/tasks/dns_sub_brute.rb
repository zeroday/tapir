require 'resolv'

def name
  "dns_sub_brute"
end

# Returns a string which describes what this task does
def description
  "Simple DNS Subdomain Bruteforce"
end

# Returns an array of valid types for this task
def allowed_types
  [Tapir::Entities::Domain]
end

## Returns an array of valid options and their description/type for this task
def allowed_options
 []
end

def setup(entity, options={})
  puts "CALLING SUPER!"
  super(entity, options)
  self
end

## Default method, subclasses must override this
def run
  super

    # :subdomain_list => list of subdomains to brute
    # :mashed_domains => try domain names w/o a dot, see if anyone's hijacked a common "subdomain"

  if @options[:subdomain_list]
    subdomain_list = @options['subdomain_list']
  else
    # Add a builtin domain list  
    subdomain_list = ["mx", "mx1", "mx2", "www", "ww2", "ns1", "ns2", "ns3", "test", "mail", "owa", "vpn", "admin",
      "gateway", "secure", "admin", "service", "tools", "doc", "docs", "network", "help", "en" ]
  end

  @task_logger.log_good "Using subdomain list: #{subdomain_list}"

  result_list = []

  subdomain_list.each do |sub|
    begin

      # Calculate the domain name
      if @options[:mashed_domains]
      
        # blatently stolen from HDM's webinar on password stealing, try without a dot to see
        # if this domain has been hijacked by someone - great for finding phishing attempts
        domain = "#{sub}#{@entity.name}"
      else  
        domain = "#{sub}.#{@entity.name}"
      end

      # Try to resolve
      resolved_address = Resolv.new.getaddress(domain)
      @task_logger.log_good "Resolved Address #{resolved_address} for #{domain}" if resolved_address
      
      # If we resolved, create the right entitys
      if resolved_address
 
        @task_logger.log_good "Creating domain and host entitys..."

        # create new host and domain entitys
        d = create_entity(Tapir::Entities::Domain, {:name => domain, :organization => @entity.organization })
        h = create_entity(Tapir::Entities::Host, {:ip_address => resolved_address})

      end

      #@task_run.save_raw_result  "#{domain}: #{resolved_address}"

    rescue Exception => e
      @task_logger.log_error "Hit exception: #{e}"
    end
  end
  
  # Keep track of our raw data

  
end

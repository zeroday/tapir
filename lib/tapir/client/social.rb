module Tapir
module Client
module Social

#
# This methods requests a specified URI and greps for strings which indicate that an
# account (doesn't) exist.
#
def check_account_exists(account_name)
  begin
    #
    # Request the uri specified as holding the account
    #
    doc = Nokogiri::HTML(open(self.check_account_uri_for(account_name), "User-Agent" => Tapir::USER_AGENT_STRING)) 
    #TapirLogger.instance.log "Got doc: #{doc}"
    #
    # Check for each string that may indicate we didn't find the account
    #
    @account_missing_strings.each do |account_missing_string| 
      if doc.to_s.include? account_missing_string
        return false
      end
    end
  
  #
  # Rescue in the case of a 404 or a redirect
  #  
  # TODO - this should really log into the task?
  rescue OpenURI::HTTPError => e 
    TapirLogger.instance.log "Error, couldn't open #{self.check_account_uri_for(account_name)}"
    return false
  rescue RuntimeError => e
    TapirLogger.instance.log "Redirection? #{e}"
    return false
    # TODO - retry on the redirection url
    #check_account_exists
  end

#
# Otherwise, lets assume it exists (TODO - this will return true if we don't have
# any @account_missing_strings - might make sense to make this a little more complicated.
#  
return true
end

end
end
end

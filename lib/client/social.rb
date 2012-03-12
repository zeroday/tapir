module Ear
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
    doc = Nokogiri::HTML(open(self.account_uri_for(account_name), "User-Agent" => Ear::USER_AGENT_STRING)) 
    
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
  rescue OpenURI::HTTPError => e 
    EarLogger.instance.log "Error, couldn't open #{self.account_uri_for(account_name)}"
  rescue RuntimeError => e
    EarLogger.instance.log "Redirection? #{e}"
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

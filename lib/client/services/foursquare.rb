module Ear
module Client
module FourSquare
  
  class WebClient
    include Ear::Client::Social
    
    def initialize
      @service_name = "foursquare"
      @account_missing_strings = ["We couldn't find the page you're looking for."]
    end
    
    def account_uri_for(account_name)
      "http://www.foursquare.com/#{account_name}"
    end
    
  end
  
end
end
end
module Ear
module Client
module FourSquare
  
  class WebClient
    include Ear::Client::Social
    
    def initialize
      @service_name = "foursquare"
      @account_missing_strings = ["404"]
    end
    
    def account_uri_for(account_name)
      "https://www.foursquare.com/#{account_name}"
    end
    
  end
  
end
end
end

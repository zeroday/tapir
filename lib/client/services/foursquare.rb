module Ear
module Client
module FourSquare
  
  class WebClient
    include Ear::Client::Social
    
    attr_accessor :service_name
    
    def initialize
      @service_name = "foursquare"
      @account_missing_strings = ["404"]
    end

    def web_account_uri_for(account_name)
      "http://www.foursquare.com/#{account_name}"
    end

    def check_account_uri_for(account_name)
      "http://www.foursquare.com/#{account_name}"
    end
    
  end
  
end
end
end

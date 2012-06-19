module Tapir
module Client
module FourSquare
  
  class WebClient
    include Tapir::Client::Social
    
    attr_accessor :service_name
    
    def initialize
      @service_name = "foursquare"
      @account_missing_strings = ["We couldn't find the page you're looking for."]
    end

    def web_account_uri_for(account_name)
      "https://www.foursquare.com/#{account_name}"
    end

    def check_account_uri_for(account_name)
      "https://www.foursquare.com/#{account_name}"
    end
    
  end
  
end
end
end

module Ear
module Client
module Facebook
  class WebClient
    include Ear::Client::Social
    
    attr_accessor :service_name

    def initialize
      @service_name = "facebook"
      @account_missing_strings = ["The page you requested cannot be displayed right now", "You may have clicked an expired link or mistyped the address"]
    end

    def web_account_uri_for(account_name)
        "http://www.facebook.com/#{account_name}"
    end

    def check_account_uri_for(account_name)    
      "http://www.facebook.com/#{account_name}"
    end
    
  end
  
  
  ## Search Service
  # http://www.facebook.com/search.php?q=User+Name
  
end
end
end

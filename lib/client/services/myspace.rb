module Ear
module Client
module Myspace
  class WebClient
    include Ear::Client::Social
    
    def initialize
      @service_name = "myspace"
      @account_missing_strings =["Your home page is undergoing routine maintenance."]
    end
    
    def account_uri_for(account_name)
      "http://www.myspace.com/#{account_name}"
    end
  
  end
end
end
end
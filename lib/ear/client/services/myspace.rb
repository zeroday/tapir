module Ear
module Client
module Myspace
  class WebClient
    include Ear::Client::Social

    attr_accessor :service_name

    def initialize
      @service_name = "myspace"
      @account_missing_strings =["Your home page is undergoing routine maintenance."]
    end
    
    def web_account_uri_for(account_name)
      "http://www.myspace.com/#{account_name}"
    end
    
    def check_account_uri_for(account_name)
      "http://www.myspace.com/#{account_name}"
    end
  
  end
end
end
end

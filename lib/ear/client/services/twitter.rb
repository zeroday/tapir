module Ear
module Client
module Twitter
  class WebClient
    include Ear::Client::Social

    attr_accessor :service_name

    def initialize
      @service_name = "twitter"
      @account_missing_strings = ["Not found", "User has been suspended"]
    end
    
    def web_account_uri_for(account_name)
      "http://www.twitter.com/#{account_name}"
    end
    
    def check_account_uri_for(account_name)
      "http://api.twitter.com/1/users/show/#{account_name}.xml"
    end
    
  end
end
end
end

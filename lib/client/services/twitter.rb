module Ear
module Client
module Twitter
  class WebClient
    include Ear::Client::Social

    def initialize
      @service_name = "twitter"
      @account_missing_strings = ["Sorry, that page"]
    end
    
    def account_uri_for(account_name)    
      "http://www.twitter.com/#{account_name}"
    end
    
  end
end
end
end

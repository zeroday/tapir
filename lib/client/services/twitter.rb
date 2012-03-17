module Ear
module Client
module Twitter
  class WebClient
    include Ear::Client::Social

    def initialize
      @service_name = "twitter"
      @account_missing_strings = ["Not found", "User has been suspended"]
    end
    
    def account_uri_for(account_name)
      "http://api.twitter.com/1/users/show/#{account_name}.xml"
    end
    
  end
end
end
end

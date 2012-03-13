module Ear
module Client
module Yfrog
  class WebClient
    include Ear::Client::Social

    def initialize
      @service_name = "yfrog"
      @account_missing_strings = ["Something went wrong"]
    end
    
    def account_uri_for(account_name)    
      "http://yfrog.com/user/#{account_name}/profile"
    end
    
  end
end
end
end

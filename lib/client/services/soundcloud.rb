module Ear
module Client
module SoundCloud
  class WebClient
    include Ear::Client::Social
    
    def initialize
      @service_name = "soundcloud"
      @account_missing_strings = ["Oops, looks like we can't find that page!"]
    end
    
    def account_uri_for(account_name)
      "http://m.soundcloud.com/#{account_name}"
    end
    
  end
end
end
end
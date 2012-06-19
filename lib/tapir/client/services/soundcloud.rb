module Tapir
module Client
module SoundCloud
 class WebClient

    include Tapir::Client::Social

    attr_accessor :service_name
    
    def initialize
      @service_name = "soundcloud"
      @account_missing_strings = ["Oops, looks like we can't find that page!", "Whoa, something went wrong and it wasn't supposed to happen."]
    end

    def web_account_uri_for(account_name)
        "http://www.soundcloud.com/#{account_name}"
    end

    def check_account_uri_for(account_name)
      "http://m.soundcloud.com/_api/resolve?url=http://soundcloud.com/#{account_name}&client_id=2Kf29hhC5mgWf62708A&format=json"
    end
    
  end
end
end
end

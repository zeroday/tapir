module Tapir
module Client
module Twitter
  class WebClient
    include Tapir::Client::Social

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

  class ApiClient

    def query(username)

      uri = "http://api.twitter.com/1/users/show/#{username}.json"

      begin
        
        contents = open("#{uri}", :allow_redirections => :safe).read
        hash = JSON.parse(contents)

      rescue Timeout::Error
      rescue OpenURI::HTTPError => e
      rescue Net::HTTPBadResponse => e
      rescue EOFError => e
      rescue SocketError => e
      rescue RuntimeError => e
      rescue SystemCallError => e
      rescue ArgumentError => e
      rescue Encoding::InvalidByteSequenceError => e
      rescue Encoding::UndefinedConversionError => e
      end
    hash
    end

  end

end
end
end

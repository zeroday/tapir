require 'linkedin'
require 'cgi'

module Tapir
module Client
module LinkedIn

  class WebClient

    include Tapir::Client::Social

    attr_accessor :service_name

    def initialize 
      @service_name = "linkedin"
      @account_missing_strings = ["The requested URL was not found on this server"]
    end

    def web_account_uri_for(account_name)
      "http://www.linkedin.com/in/#{account_name}"
    end

    def check_account_uri_for(account_name)
      "http://www.linkedin.com/in/#{account_name}"
    end
    
  end
  
  class DirectoryClient

    include Tapir::Client::Social
  
    attr_accessor :service_name
    
    def initialize 
      @service_name = "linkedin"
      @account_missing_strings = ["could not be found"]
    end

    def pretty_account_uri_for(first_name, last_name)
      "http://www.linkedin.com/pub/dir/#{first_name}/#{last_name}"
    end

    def account_uri_for(first_name, last_name)
      "http://www.linkedin.com/pub/dir/#{first_name}/#{last_name}"
    end
    
  end

# This class represents the linkedin API
# 
# Reference: 
# https://github.com/pengwynn/linkedin
#
class SearchService

  def initialize
    
    @client = LinkedIn::Client.new(Tapir::ApiKeys.instance.keys['linkedin_api_key'], Tapir::ApiKeys.instance.keys['linkedin_secret_key'])
    rtoken = client.request_token.token
    rsecret = client.request_token.secret

    # to test from your desktop, open the following url in your browser
    # and record the pin it gives you
    @client.request_token.authorize_url

    # then fetch your access keys
    access_keys = @client.authorize_from_request(rtoken, rsecret, pin)

    # or authorize from previously fetched access keys
    @client.authorize_from_access(access_keys.first, access_keys.last)
  end

  # 
  # Takes: a search string
  # 
  # Ruturns: An array of search results 
  #
  def search_company(company_name)
    @client.search(company_name, :company)
  end

  def search_person(person_name)
    @client.search person_name, :person
  end

end

# This class represents a corporation as returned by the Linkedin service. 
class SearchResult

  attr_accessor :title

  def initialize
  end

  # 
  #  Takes: A JSON search result
  #
  #  Returns: Nothing
  #
  def parse(result)
    @title = result['title']
  end
  
  def to_s
    
  end
  
end

end
end
end

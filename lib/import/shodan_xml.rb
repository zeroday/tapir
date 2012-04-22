#
# <host city="Culver City" country="USA" hostnames="pwa206.wildgate.net" ip="66.52.2.206" port="23" updated="13.08.2010">
# <data>
#   Lantronix MSS1 Version STI3.5/5(981103)
#   Type HELP at the 'Local_2&gt; ' prompt for assistance.
#   Login password&gt; 
#  </data>
#</host>
#
#

#
# Sax parsing sucks. TODO - rewrite this with the Reader API
# http://stackoverflow.com/questions/9984621/sax-parsing-strange-element-with-nokogiri
#

module Ear
module Import

class ShodanXml < Nokogiri::XML::SAX::Document

  attr_accessor :shodan_hosts
  def initialize
    @shodan_hosts = []
  end

  def start_element(name, attrs = [])
    @content = ""
    @attrs = attrs
    
    if name == "host"
      #
      # create a host object & set the vars
      #
      @current_host = ShodanHost.new
      @current_host.city = @attrs[0].last
      @current_host.country = @attrs[1].last
      @current_host.hostnames = @attrs[2].last
      @current_host.ip_address = @attrs[3].last
      @current_port = @attrs[4].last
      @current_host.updated = @attrs[5].last
      @shodan_hosts << @current_host
    end
    
  end

  def characters(string)
    @content << string if @content
  end
  
  def cdata_block(string)
    characters(string)
  end

  def end_element(name)
    if name == "data"
      #
      # This always follows a host object, so let's add the port & associate 
      #
      @shodan_hosts.last.services << ShodanService.new(@current_port, @content) unless @shodan_hosts = []
      @current_port=nil
    end

    # Reset this so we don't grab content accidentally

    @content = nil
  end
  
end

class ShodanHost
    attr_accessor :city, :country, :hostnames, :ip_address, :services, :updated
    def initialize(city=nil, country=nil, hostnames=[], ip_address=nil, services=[], updated=nil)
      @city = city
      @country = country
      @hostnames = hostnames
      @ip_address = ip_address
      @services = services
      @updated = updated
    end
end

class ShodanService
  attr_accessor :num, :data
  def initialize(num=nil,data=nil)
    @num = num
    @data = data
  end
end

end
end


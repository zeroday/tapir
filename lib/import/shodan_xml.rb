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
module Ear
module Import
class ShodanXml < Nokogiri::XML::SAX::Document

  def start_element(name, attrs = [])
    if name == "host"
    
      #
      # Stick all the elements in an array
      #
      city = attrs[0].last
      country = attrs[1].last
      hostnames = attrs[2].last
      ip_address = attrs[3].last
      port = attrs[4].last
      updated = attrs[5].last
      
      #
      # Create the objects
      #
      d = ::Domain.create(:name => hostnames) if hostnames.kind_of? String
      h = ::Host.create :ip_address => ip_address
      p = ::NetSvc.create :proto => "tcp", :port_num => port, :fingerprint => "TODO"
    end

    if name == "data"
      # 
      # Skip this for now
      #
    end
    
  end
  
  def end_element(name)
  end
    
end
end
end

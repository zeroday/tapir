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

class ShodanXml < Nokogiri::XML::SAX::Document

  def start_element(name, attrs = [])
    puts "starting: #{name}"
    
    if name == "host"
    
      #
      # Stick all the elements in an array
      #
      city = attrs['city']
      country = attrs['country']
      hostnames = attrs['hostnames']
      ip_address = attrs['ip']
      port = attrs['port']
      updated = attrs['updated']
      
      #
      # Create the objects
      #
      d = Domain.create(:name => hostnames) if hostnames.kind_of? String
      h = Host.create :ip_address => ip_address
      p = NetService.create :proto => "tcp", :port_num => port, :fingerprint => "TODO"
    end

    if name == "data"
      # 
      # Skip this for now
      #
    end
    
  end
  
  def end_element name
    puts "ending: #{name}"
  end
    
end

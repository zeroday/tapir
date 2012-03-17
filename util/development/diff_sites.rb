require "#{File.expand_path(File.dirname(__FILE__))}/../../config/environment"

begin
  doc1 = Nokogiri::HTML(open("http://www.twitter.com/#!/jcranx", "User-Agent" => Ear::USER_AGENT_STRING))
  doc2 = Nokogiri::HTML(open("http://www.twitter.com/#!/jcran", "User-Agent" => Ear::USER_AGENT_STRING))

  File.open("/tmp/doc1.html", "w").write doc1.to_s
  File.open("/tmp/doc2.html", "w").write doc2.to_s

  string = `diff /tmp/doc1.html /tmp/doc2.html`
  puts "diff:"
  puts string

rescue Exception => e
  puts "Error: #{e}"
end

`meld /tmp/doc1.html /tmp/doc2.html`


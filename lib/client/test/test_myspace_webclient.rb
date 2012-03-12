# Rails Environment
$:.unshift(File.join( File.expand_path(File.dirname(__FILE__)), "..", "..", "..", "config"))

require 'environment'
require 'test/unit'

class TestMyspaceWebClient < Test::Unit::TestCase

  def test_valid_account
    x = Ear::Client::Myspace::WebClient.new
    assert x.check_account_exists "justinbieber"
  end

  def test_invalid_account
    x = Ear::Client::Myspace::WebClient.new
    assert !(x.check_account_exists "thiscouldnotpossiblyexist#{rand(10000)}")
  end

end

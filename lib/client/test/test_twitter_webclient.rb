# Rails Environment
$:.unshift(File.join( File.expand_path(File.dirname(__FILE__)), "..", "..", "..", "config"))

require 'environment'
require 'test/unit'



class TestTwitterWebClient < Test::Unit::TestCase

  def test_valid_account
    x = Ear::Client::Twitter::WebClient.new
    assert x.check_account_exists "jcran"
  end

  def test_invalid_account
    x = Ear::Client::Twitter::WebClient.new
    assert !(x.check_account_exists "thiscouldnotpossiblyexist#{rand(10000)}")
  end

end

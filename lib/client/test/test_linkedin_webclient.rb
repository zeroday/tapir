# Rails Environment
$:.unshift(File.join( File.expand_path(File.dirname(__FILE__)), "..", "..", "..", "config"))

require 'environment'
require 'test/unit'

class TestLinkedInWebClient < Test::Unit::TestCase

  def test_valid_account
    x = Ear::Client::LinkedIn::WebClient.new
    assert x.check_account_exists("jcran"), "weird, found a string indicating this profile doesn't exist"
  end

  def test_invalid_account
    x = Ear::Client::LinkedIn::WebClient.new
    assert !(x.check_account_exists "thiscouldnotpossiblyexist#{rand(1000000)}"), 
      "weird, found no strings we'd expect to find when an account is missing"
  end

end

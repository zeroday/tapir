# Rails Environment
$:.unshift(File.join( File.expand_path(File.dirname(__FILE__)), "..", "..", "..", "config"))

require 'environment'
require 'test/unit'

class TestFacebookWebClient < Test::Unit::TestCase

  def test_valid_account
    x = Ear::Client::Facebook::WebClient.new
    assert x.check_account_exists "jonathan.cran"
  end

  def test_invalid_account
    x = Ear::Client::Facebook::WebClient.new
    assert !(x.check_account_exists "thiscouldnotpossiblyexist#{rand(10000)}")
  end

end

# Rails Environment
$:.unshift(File.join( File.expand_path(File.dirname(__FILE__)), "..", "..", "..", "config"))

require 'environment'
require 'test/unit'

class TestSoundCloudWebClient < Test::Unit::TestCase

  def test_valid_account
    x = Tapir::Client::SoundCloud::WebClient.new
    assert x.check_account_exists "justinbieber"
  end

  def test_invalid_account
    x = Tapir::Client::SoundCloud::WebClient.new
    assert !(x.check_account_exists "thiscouldnotpossiblyexistdammit")
  end

end

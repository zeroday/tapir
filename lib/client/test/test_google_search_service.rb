# Rails Environment
$:.unshift(File.join( File.expand_path(File.dirname(__FILE__)), "..", "..", "..", "config"))

require 'environment'
require 'test/unit'



class TestGoogleSearchService < Test::Unit::TestCase

  def test_google_search_acme
    x = Ear::Client::Google::SearchService.new
    results = x.search "acme"
    assert results.count == 8, "Wrong count, should be 8, is #{results.count}"
  end

  def test_google_search_test
    x = Ear::Client::Google::SearchService.new
    results = x.search "test"
    assert results.count == 8, "Wrong count, should be 8, is #{results.count}"
  end

end

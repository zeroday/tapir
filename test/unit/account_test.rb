#require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test "Account should require a service name, account name, and uri" do
    assert true if Account.create :service_name => "test", :account_name => "test", :uri => "www.test.com/test"
  end
end

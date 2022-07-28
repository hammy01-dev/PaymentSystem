require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  setup do
    @subscription = subscriptions(:one)
  end

  test 'should  save as  the billing date is default to now' do
    @subscription.billing_date = ''
    assert @subscription.save
  end

  test 'Subscription should have 2 transactions' do
    assert_equal 2, @subscription.transactions.size

  end

end

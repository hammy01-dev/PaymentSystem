# frozen_string_literal: true

require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  setup do
    @subscription = subscriptions(:one)
    @plan = plans(:one)
    @users = users(:one)
  end

  test 'should  save as  the billing date is default to datetime.now' do
    @subscription.billing_date = ''
    assert @subscription.save
  end

  test 'Subscription should have 2 transactions' do
    assert_equal 2, @subscription.transactions.size
  end
  test 'Subscriptions scopes' do
    assert_equal Subscription.get({ plan_id: @plan.id, user_id: @users.id }), Subscription.where(plan_id: @plan.id, user_id: @users.id).ids.first
  end
end

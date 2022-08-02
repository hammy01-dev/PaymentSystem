# frozen_string_literal: true

require 'test_helper'


class PlanTest < ActiveSupport::TestCase
  setup do
    @plan = plans(:one)
  end
  test 'should not save Plan without Name' do
    @plan.name = ''
    assert_not @plan.save
  end

  test 'should not save feature when name of feature is greater then 50 characters' do
    @plan.name = "Plan name is too long to be saved let's test it to see if it's working"
    assert_not @plan.save, 'Could not saved the plan as name  is too long'
  end

  test 'should not save Plan without Monthly fee' do
    @plan.monthly_fee = nil
    assert_not @plan.save, 'Could not saved the plan without a monthly_fee'
  end

  test 'should not save Plan without Integer in  Monthly fee' do
    @plan.monthly_fee = '2hhh33'
    assert_not @plan.save, 'Could not saved the plan as monthly_fee is string'
  end

  test 'should save Plan' do
    assert @plan.save
  end

  test 'Plan should have two features' do
    assert_equal 2, @plan.features.size
  end

  test 'Plan should have two subscriptions' do
    assert_equal 2, @plan.subscriptions.size
  end
end

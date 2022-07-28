# frozen_string_literal: true

require 'test_helper'

class UsageTest < ActiveSupport::TestCase
  setup do
    @usage = usages(:one)
    p @usage
  end

  test 'should save usage as all required fields are present' do
    assert @usage.save
  end

  test 'should save usage as usage is nil' do
    @usage.usage = nil
    assert_not @usage.save
  end

  test 'should not save usage without subscription id  ' do
    @usage.subscription_id = nil
    assert_not @usage.save, 'Could not saved the usage without a subscription id'
  end

  test 'should not save usage without feature id' do
    @usage.feature_id = nil
    assert_not @usage.save, 'Could not saved usage as feature id is nil'
  end



end

# frozen_string_literal: true

require 'test_helper'

class FeatureTest < ActiveSupport::TestCase
  setup do
    @feature = features(:one)
  end

  test 'should not save Feature without Name' do
    @feature.name = ''
    assert_not @feature.save
  end

  test 'should not save feature when name of feature is greater then 50 characters' do
    @feature.name = "Feature name is too long to be saved let's test it to see if it's working"
    assert_not @feature.save, 'Could not saved the feature as name  is too long'
  end

  test 'should not save feature without code' do
    @feature.code = nil
    assert_not @feature.save, 'Could not saved the feature without a code'
  end
  test 'should not save feature without Integer in  code' do
    @feature.code = '233r'
    assert_not @feature.save, 'Could not saved the feature as monthly_fee is string'
  end

  test 'should not save feature without unit price' do
    @feature.unit_price = nil
    assert_not @feature.save, 'Could not saved the feature without a unit_price'
  end

  test 'should not save feature without Integer in  unit price' do
    @feature.unit_price = '233r'
    assert_not @feature.save, 'Could not saved the feature as unit price is string'
  end

  test 'should not save feature without max_unit_limit' do
    @feature.max_unit_limit = nil
    assert_not @feature.save, 'Could not saved the feature without a max_unit_limit'
  end

  test 'should not save feature without Integer in  max_unit_limit' do
    @feature.max_unit_limit = '233r'
    assert_not @feature.save, 'Could not saved the feature as max_unit_limit is string'
  end

  test 'should  saved the  feature' do
    assert @feature.save, 'Feature would  not save as code is not  unique'
  end

  test 'Feature should have 2 usages' do
    assert_equal 2, @feature.usages.size
  end
end

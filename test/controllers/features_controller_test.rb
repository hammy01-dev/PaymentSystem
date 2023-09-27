# frozen_string_literal: true

require 'test_helper'

class FeatureControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in(@user)
    @user1 = users(:two)
    @plan = plans(:one)
    @feature = features(:one)
  end

  test 'should not  go to the features new page as the signed in user is not admin' do
    get new_plan_feature_path(@plan)
    assert_response :redirect
  end

  test 'should not  go to the feature edit page as the signed in user is not admin' do
    get edit_feature_path(@plan)
    assert_response :redirect
  end

  test 'should not  perform the feature destroy action as signed in user is not admin' do
    delete feature_path(@feature)
    assert_response :redirect
  end
  test 'should not  perform the feature create action as signed in user is not admin' do
    post plan_features_path(@plan), params: { feature: { code: 30, description: 'testing feature', unit_price: 200, max_unit_limit: 300 } }
    assert_redirected_to :root
  end

  test 'should show the index as both admin and buyers have authorizations' do
    get plan_features_path(@plan)
    assert_response :success
  end

  test 'should not update feature as user is not admin' do
    patch feature_url(@feature), params: { feature: { name: 'Feature No A', code: 10, unit_price: 10, max_unit_limit: 20 } }
    assert_redirected_to root_path
  end

  def admin_setup
    sign_out(@user)
    @user = users(:two)
    sign_in(@user)
  end

  test 'should  update feature as the signed in user is admin' do
    admin_setup
    patch feature_url(@feature), params: { feature: { name: 'Feature No A', code: 10, unit_price: 10, max_unit_limit: 20 } }
    assert_redirected_to plan_features_path(@plan)
  end

  test 'should  not update feature as the object is invalid' do
    admin_setup
    patch feature_url(@feature), params: { feature: { name: 'Feature No A', code: '1302ere', unit_price: 10, max_unit_limit: 20 } }
    assert_template :edit
  end

  test 'should   go to the projects new page as the signed in user is  admin' do
    admin_setup
    get new_plan_feature_path(@feature)
    assert_response :success
  end

  test 'should go to the projects edit page as the signed in user is  admin' do
    admin_setup
    get edit_feature_path(@plan)
    assert_response :success
  end

  test 'should perform the feature destroy action as signed in user is  admin' do
    admin_setup
    assert_difference('Feature.count', -1) do
      delete feature_path(@feature)
    end
    assert_redirected_to plans_path
  end

  test 'should perform the feature create action as signed in user is  admin' do
    admin_setup
    post plan_features_path(@plan), params: { feature: { name: 'Feature No A', code: 230, unit_price: 10, max_unit_limit: 20 } }
    assert_redirected_to plan_features_path
  end

  test 'should not perform the feature create action as the object is invalid' do
    admin_setup
    post plan_features_path(@plan), params: { feature: { name: 'Feature No A', code: 'wwe', unit_price: 10, max_unit_limit: 20 } }
    assert_template :new
  end
end

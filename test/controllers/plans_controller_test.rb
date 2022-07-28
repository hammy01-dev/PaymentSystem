# frozen_string_literal: true

require 'test_helper'

class PlanControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in(@user)
    @user1 = users(:two)
    @plan = plans(:one)
    @feature = features(:one)
  end

  test 'should not  go to the projects new page as the signed in user is not admin' do
    get new_plan_path
    assert_response :redirect
  end

  test 'should not  go to the projects edit page as the signed in user is not admin' do
    get edit_plan_path(@plan)
    assert_response :redirect
  end

  test 'should not  perform the project destroy action as signed in user is not admin' do
    delete plan_path(@plan)
    assert_response :redirect
  end

  test 'should not  perform the project create action as signed in user is not admin' do
    post plans_path, params: { plan: { name: 'PLan2 ', monthly_fee: 200 } }
    assert_response :redirect
  end

  test 'should show the index as both admin and buyers have authorizations' do
    get plans_path
    assert_response :success
  end

  test 'should not update plans' do
    patch plan_url(@plan), params: { plan: { name: 'PlanA' } }
    assert_redirected_to root_path
  end

  def admin_setup
    sign_out(@user)
    @user = users(:two)

    sign_in(@user)
    @plan = plans(:one)
    @feature = features(:one)
  end

  test 'should  go to the projects new page as the signed in user is  admin' do
    admin_setup
    get new_plan_path
    assert_response :success
  end

  test 'should go to the projects edit page as the signed in user is  admin' do
    admin_setup
    get edit_plan_path(@plan), params: { plan: { name: 'PLan3' } }
    assert_response success
  end

  test 'should   perform the plan destroy action as signed in user is  admin' do
    admin_setup
    delete plan_path(@plan)
    assert_response :success
  end

  test 'should perform the project create action as signed in user is  admin' do
    admin_setup
    post plans_path, params: { plan: { name: 'PLan2 ', monthly_fee: 200 } }
    assert_redirected_to root_path
  end

  test 'should not perform the project create action as object is not valid' do
    admin_setup
    post plans_path, params: { plan: { name: '', monthly_fee: 200 } }
    assert_redirected_to root_path
  end

  test 'should update plans' do
    admin_setup
    patch plan_url(@plan), params: { plan: { name: 'PlanA' } }
    assert_redirected_to root_path
  end

  test 'should not update plans user is admin but update operation is invalid' do
    admin_setup
    put plan_url(@plan), params: { plan: { name: '' } }
    assert_template :edit
  end
end

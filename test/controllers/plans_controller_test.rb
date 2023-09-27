# frozen_string_literal: true

require 'test_helper'
require 'minitest/autorun'
require 'minitest/stub_any_instance'
class PlanControllerTest < ActionDispatch::IntegrationTest
  class MockPlan
    def destroy

    end
  end
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

  # test 'should not  perform the project destroy action as signed in user is not admin' do
  #   delete plan_path(@plan)
  #   assert_response :redirect
  # end

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
    assert_response :success
  end

  test 'should   perform the plan destroy action as signed in user is  admin' do
    admin_setup
    assert_difference('Plan.count', -1) do
      delete plan_path(@plan)
    end
    assert_redirected_to :root
  end

  test 'should perform the project create action as signed in user is  admin' do
    admin_setup
    post plans_path, params: { plan: { name: 'PLan2 ', monthly_fee: 200 } }
    assert_redirected_to root_path
  end

  test 'should not perform the plan create action as object is not valid' do
    admin_setup
    post plans_path, params: { plan: { name: '', monthly_fee: 200 } }
    assert_template :new
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

  test 'testing negative delete' do
    # admin_setup
    # # assert_difference('Plan.count', -1) do
    # #   delete plan_path(@plan)
    # byebug
    # @plan = MockPlan.new
    # plans = PlansController.new
    # @plan.stub :destroy, true do
    #   byebug
    #   plans.destroy
    #   assert_response :redirect
    # end

    plan = plans(:one)
    Plan.stub_any_instance(:destroyed?, false) do
      assert_difference('Plan.count', 0) do
        delete plan_path(plan)
        end
      end
    end


  end




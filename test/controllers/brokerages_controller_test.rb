require 'test_helper'

class BrokeragesControllerTest < ActionController::TestCase
  setup do
    @brokerage = brokerages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:brokerages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create brokerage" do
    assert_difference('Brokerage.count') do
      post :create, brokerage: { name: @brokerage.name, website: @brokerage.website }
    end

    assert_redirected_to brokerage_path(assigns(:brokerage))
  end

  test "should show brokerage" do
    get :show, id: @brokerage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @brokerage
    assert_response :success
  end

  test "should update brokerage" do
    patch :update, id: @brokerage, brokerage: { name: @brokerage.name, website: @brokerage.website }
    assert_redirected_to brokerage_path(assigns(:brokerage))
  end

  test "should destroy brokerage" do
    assert_difference('Brokerage.count', -1) do
      delete :destroy, id: @brokerage
    end

    assert_redirected_to brokerages_path
  end
end

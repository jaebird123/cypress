require 'test_helper'

class VendorsControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
  end

  # This test does not currently work because show page is not made yet
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should make new vendor" do
    get :new
    assert_not_nil assigns[:vendor]
  end

  test "should create vendor" do
    # $temp = vendors(:fixed_vendor_with_pocs)
    # byebug
    vendor = FactoryGirl.build(:vendor_with_pocs)
    byebug
    post :create, vendor: vendor
    assert_response :success
  end

end
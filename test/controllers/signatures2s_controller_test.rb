require 'test_helper'

class Signatures2sControllerTest < ActionDispatch::IntegrationTest
  setup do
    @signatures2 = signatures2s(:one)
  end

  test "should get index" do
    get signatures2s_url
    assert_response :success
  end

  test "should get new" do
    get new_signatures2_url
    assert_response :success
  end

  test "should create signatures2" do
    assert_difference('Signatures2.count') do
      post signatures2s_url, params: { signatures2: {  } }
    end

    assert_redirected_to signatures2_url(Signatures2.last)
  end

  test "should show signatures2" do
    get signatures2_url(@signatures2)
    assert_response :success
  end

  test "should get edit" do
    get edit_signatures2_url(@signatures2)
    assert_response :success
  end

  test "should update signatures2" do
    patch signatures2_url(@signatures2), params: { signatures2: {  } }
    assert_redirected_to signatures2_url(@signatures2)
  end

  test "should destroy signatures2" do
    assert_difference('Signatures2.count', -1) do
      delete signatures2_url(@signatures2)
    end

    assert_redirected_to signatures2s_url
  end
end

require 'test_helper'

class InstituteControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get institute_new_url
    assert_response :success
  end

  test "should get index" do
    get institute_index_url
    assert_response :success
  end

  test "should get show" do
    get institute_show_url
    assert_response :success
  end

  test "should get edit" do
    get institute_edit_url
    assert_response :success
  end

  test "should get create" do
    get institute_create_url
    assert_response :success
  end

  test "should get update" do
    get institute_update_url
    assert_response :success
  end

  test "should get destroy" do
    get institute_destroy_url
    assert_response :success
  end

end

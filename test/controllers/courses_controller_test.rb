require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get courses_new_url
    assert_response :success
  end

  test "should get show" do
    get courses_show_url
    assert_response :success
  end

  test "should get index" do
    get courses_index_url
    assert_response :success
  end

  test "should get edit" do
    get courses_edit_url
    assert_response :success
  end

end

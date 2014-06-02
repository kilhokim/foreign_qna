require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get en_index" do
    get :en_index
    assert_response :success
  end

  test "should get en_index_copy" do
    get :en_index_copy
    assert_response :success
  end

  test "should get highlight" do
    get :highlight
    assert_response :success
  end

  test "should get mysnu" do
    get :mysnu
    assert_response :success
  end

  test "should get mysnu_copy" do
    get :mysnu_copy
    assert_response :success
  end

  test "should get shortcuts" do
    get :shortcuts
    assert_response :success
  end

  test "should get shortcuts_copy" do
    get :shortcuts_copy
    assert_response :success
  end

  test "should get shortcut_count" do
    get :shortcut_count
    assert_response :success
  end

  test "should get personal" do
    get :personal
    assert_response :success
  end

  test "should get news" do
    get :news
    assert_response :success
  end

  test "should get banner" do
    get :banner
    assert_response :success
  end

  test "should get event" do
    get :event
    assert_response :success
  end

  test "should get favorite" do
    get :favorite
    assert_response :success
  end

  test "should get timetable" do
    get :timetable
    assert_response :success
  end

  test "should get maillist" do
    get :maillist
    assert_response :success
  end

  test "should get lecture" do
    get :lecture
    assert_response :success
  end

  test "should get notice" do
    get :notice
    assert_response :success
  end

end

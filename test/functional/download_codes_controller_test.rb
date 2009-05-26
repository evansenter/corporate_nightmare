require 'test_helper'

class DownloadCodesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:download_codes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create download_code" do
    assert_difference('DownloadCode.count') do
      post :create, :download_code => { }
    end

    assert_redirected_to download_code_path(assigns(:download_code))
  end

  test "should show download_code" do
    get :show, :id => download_codes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => download_codes(:one).to_param
    assert_response :success
  end

  test "should update download_code" do
    put :update, :id => download_codes(:one).to_param, :download_code => { }
    assert_redirected_to download_code_path(assigns(:download_code))
  end

  test "should destroy download_code" do
    assert_difference('DownloadCode.count', -1) do
      delete :destroy, :id => download_codes(:one).to_param
    end

    assert_redirected_to download_codes_path
  end
end

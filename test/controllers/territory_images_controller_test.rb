require 'test_helper'

class TerritoryImagesControllerTest < ActionController::TestCase
  setup do
    @territory_image = territory_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:territory_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create territory_image" do
    assert_difference('TerritoryImage.count') do
      post :create, territory_image: { image: @territory_image.image, territory_id: @territory_image.territory_id }
    end

    assert_redirected_to territory_image_path(assigns(:territory_image))
  end

  test "should show territory_image" do
    get :show, id: @territory_image
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @territory_image
    assert_response :success
  end

  test "should update territory_image" do
    patch :update, id: @territory_image, territory_image: { image: @territory_image.image, territory_id: @territory_image.territory_id }
    assert_redirected_to territory_image_path(assigns(:territory_image))
  end

  test "should destroy territory_image" do
    assert_difference('TerritoryImage.count', -1) do
      delete :destroy, id: @territory_image
    end

    assert_redirected_to territory_images_path
  end
end

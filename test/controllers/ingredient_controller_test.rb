require 'test_helper'

class IngredientControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ingredient_index_url
    assert_response :success
  end

  test "should get create" do
    get ingredient_create_url
    assert_response :success
  end

  test "should get show" do
    get ingredient_show_url
    assert_response :success
  end

  test "should get new" do
    get ingredient_new_url
    assert_response :success
  end

  test "should get update" do
    get ingredient_update_url
    assert_response :success
  end

  test "should get delete" do
    get ingredient_delete_url
    assert_response :success
  end

end

require 'test_helper'

class IngredientSetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ingredient_set = ingredient_sets(:one)
  end

  test "should get index" do
    get ingredient_sets_url
    assert_response :success
  end

  test "should get new" do
    get new_ingredient_set_url
    assert_response :success
  end

  test "should create ingredient_set" do
    assert_difference('IngredientSet.count') do
      post ingredient_sets_url, params: { ingredient_set: { position: @ingredient_set.position, title: @ingredient_set.title } }
    end

    assert_redirected_to ingredient_set_url(IngredientSet.last)
  end

  test "should show ingredient_set" do
    get ingredient_set_url(@ingredient_set)
    assert_response :success
  end

  test "should get edit" do
    get edit_ingredient_set_url(@ingredient_set)
    assert_response :success
  end

  test "should update ingredient_set" do
    patch ingredient_set_url(@ingredient_set), params: { ingredient_set: { position: @ingredient_set.position, title: @ingredient_set.title } }
    assert_redirected_to ingredient_set_url(@ingredient_set)
  end

  test "should destroy ingredient_set" do
    assert_difference('IngredientSet.count', -1) do
      delete ingredient_set_url(@ingredient_set)
    end

    assert_redirected_to ingredient_sets_url
  end
end

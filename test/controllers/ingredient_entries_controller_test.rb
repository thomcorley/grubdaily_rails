require 'test_helper'

class IngredientEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ingredient_entry = ingredient_entries(:one)
  end

  test "should get index" do
    get ingredient_entries_url
    assert_response :success
  end

  test "should get new" do
    get new_ingredient_entry_url
    assert_response :success
  end

  test "should create ingredient_entry" do
    assert_difference('IngredientEntry.count') do
      post ingredient_entries_url, params: { ingredient_entry: {  } }
    end

    assert_redirected_to ingredient_entry_url(IngredientEntry.last)
  end

  test "should show ingredient_entry" do
    get ingredient_entry_url(@ingredient_entry)
    assert_response :success
  end

  test "should get edit" do
    get edit_ingredient_entry_url(@ingredient_entry)
    assert_response :success
  end

  test "should update ingredient_entry" do
    patch ingredient_entry_url(@ingredient_entry), params: { ingredient_entry: {  } }
    assert_redirected_to ingredient_entry_url(@ingredient_entry)
  end

  test "should destroy ingredient_entry" do
    assert_difference('IngredientEntry.count', -1) do
      delete ingredient_entry_url(@ingredient_entry)
    end

    assert_redirected_to ingredient_entries_url
  end
end

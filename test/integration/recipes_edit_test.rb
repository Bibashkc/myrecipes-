require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @chef = Chef.create!(chefname: "bibash", email: "bibash@example.com", password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "vegetable saute", description: "greate vegetable sautee, add oil",chef: @chef)
  end
  
  test "reject invalid recipe update" do
    sign_in_as(@chef, "password")
    get edit_recipe_url(@recipe)
    assert_template 'recipes/edit'
    patch recipe_url(@recipe), params: {recipe: {name: " ", description: " "}}
    assert_template 'recipes/edit'
    assert_select 'body'
  end
  
  test "successfully edit a recipe" do
    sign_in_as(@chef, "password")
    get edit_recipe_url(@recipe)
    assert_template 'recipes/edit'
    updated_name = "recipe name"
    updated_description = "recipe description"
    patch recipe_url(@recipe), params: {recipe: {name: updated_name, description: updated_description}}
    assert_redirected_to @recipe
    assert_not flash.empty?
    @recipe.reload 
    assert_match updated_name, @recipe.name
    assert_match updated_description, @recipe.description
  end

end

require 'test_helper'

class RecipeDeleteTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @chef = Chef.create!(chefname: "bibash", email: "bibash@example.com", password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "vegetable saute", description: "greate vegetable sautee, add oil",chef: @chef)
  end
  
  test "successfully delete a recipe " do 
    get recipe_url(@recipe)
    assert 'recipes/show'
    assert_select 'a[href=?]', recipe_url(@recipe), text: "Delete this recipe"
    assert_difference 'Recipe.count', -1 do
      delete recipe_url(@recipe)
    end
    assert_redirected_to recipes_url
    assert_not flash.empty?
  end
  
end

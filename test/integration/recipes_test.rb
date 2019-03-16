require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @chef = Chef.create!(chefname: "bibash", email: "bibash@example.com")
    @recipe = Recipe.create(name: "vegetable saute", description: "greate vegetable sautee, add oil",chef: @chef)
    @recipe2 = @chef.recipes.build(name: "chicken saute", description: "great chicken dish")
    @recipe2.save
  end
  
  
  test "shoudl get recipes index" do 
    get recipes_url 
    assert_response :success
  end
  
  test "should get recipes listing" do 
    get recipes_url
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end
  
end

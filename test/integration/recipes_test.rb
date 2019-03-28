require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @chef = Chef.create!(chefname: "bibash", email: "bibash@example.com", password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "vegetable saute", description: "greate vegetable sautee, add oil",chef: @chef)
    @recipe2 = @chef.recipes.build(name: "chicken saute", description: "great chicken dish")
    @recipe2.save
  end
  
  
  test "should get recipes index" do 
    get recipes_url 
    assert_response :success
  end
  
  test "should get recipes listing" do 
    get recipes_url
    assert_template 'recipes/index'
    # assert_select "a[herf=?]", recipe_url(@recipe), text: @recipe.name
    # assert_select "a[herf=?]", recipe_url(@recipe2), text: @recipe2.name
  end
  
  test "should get recipes show" do 
    get recipe_url(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @recipe.chef.chefname, response.body
    assert_select 'a[href=?]', edit_recipe_url(@recipe), text: "Edit this recipe"
    assert_select 'a[href=?]', recipe_url(@recipe), text: "Delete this recipe"
    assert_select 'a[href=?]', recipes_url, text: "Return to recipe listings"
  end
  
  test "create new valid recipe" do 
    get new_recipe_url
    assert_response :success
  end
  
  test "reject invalid recipe submissions" do 
    get new_recipe_url
    assert_template 'recipes/new'
    assert_no_difference 'Recipe.count' do 
      post recipes_url, params: {recipe: {name:" ", description: " "}}
    end
    assert_template 'recipes/new'
    assert_select 'body'
  end
  
end

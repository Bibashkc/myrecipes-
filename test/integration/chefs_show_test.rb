require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @chef = Chef.create!(chefname: "bibash", email: "bibash@example.com", password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "vegetable saute", description: "greate vegetable sautee, add oil",chef: @chef)
    @recipe2 = @chef.recipes.build(name: "chicken saute", description: "great chicken dish")
    @recipe2.save
  end
  
  test "should get chefs show" do 
    get chef_url(@chef)
    assert_template 'chefs/show'
    assert_select "a[href=?]", recipe_url(@recipe), text: @recipe.name.split(" ").map(&:capitalize).join(" ")
    assert_select "a[href=?]", recipe_url(@recipe2), text: @recipe2.name.split(" ").map(&:capitalize).join(" ")
    assert_match @chef.chefname, response.body
  end
end

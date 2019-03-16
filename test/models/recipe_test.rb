require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.create!(chefname: "Bibash", email: "bibash@example.com")
    @recipe = @chef.recipes.build(name:"vegetable", description: "great vegetable recipe")
  end
  
  test "recipe without chef_id is invalid" do 
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end
  
  test "recipe should be valid" do 
    assert @recipe.valid?
  end
  
  test "name to be present" do 
    @recipe.name = ""
    assert_not @recipe.valid?
  end
  
  test "description should be present" do 
    @recipe.description = " "
    assert_not @recipe.valid?
  end
  
  test "description should not be less than 5 characters" do 
    @recipe.description = "aaa"
    assert_not @recipe.valid?
  end
  
  test "description should not be greater than 500 characters" do 
     @recipe.description = "a" * 501
     assert_not @recipe.valid?
  end
end
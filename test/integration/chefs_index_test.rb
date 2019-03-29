require 'test_helper'

class ChefsIndexTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @chef = Chef.create!(chefname: "bibash", email: "bibash@example.com", 
    password: "password", password_confirmation: "password")
  end
  
  test "should get chefs index page" do 
    get chefs_url
    assert_response :success
  end
  
  test"should get chefs listing" do 
    get chefs_url
    assert_template 'chefs/index'
    assert_select "a[href=?]", chef_url(@chef), text: @chef.chefname.split(" ").map(&:capitalize).join(" ")
  end
end

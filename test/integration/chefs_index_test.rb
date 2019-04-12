require 'test_helper'

class ChefsIndexTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @chef = Chef.create!(chefname: "bibash", email: "bibash@example.com", 
    password: "password", password_confirmation: "password")
    @admin_user = Chef.create!(chefname: "bibash1", email: "bibash1@example.com", 
    password: "password", password_confirmation: "password", admin: true)
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
  
  test "should delete chef" do 
    sign_in_as(@admin_user,"password")
    get chefs_url
    assert_template 'chefs/index'
    assert_difference 'Chef.count', -1 do 
      delete chef_path(@chef)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end
end

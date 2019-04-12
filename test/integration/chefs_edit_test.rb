require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @chef = Chef.create!(chefname: "bibash", email: "bibash@example.com", 
    password: "password", password_confirmation: "password")
  end
  
  test "reject and invalid edit " do 
    sign_in_as(@chef, "password")
    get edit_chef_url(@chef)
    assert_template 'chefs/edit'
    patch chef_url(@chef), params: {chef: {chefname: " ", email: "bibash@example.com"}}
    assert_template 'chefs/edit'
    assert !flash.empty?
  end
  
  test "accept valid edit " do 
    sign_in_as(@chef, "password")
    get edit_chef_url(@chef)
    assert_template 'chefs/edit'
    patch chef_url(@chef), params: {chef: {chefname: "bibashkc", email:"bibash@example.com"}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "bibashkc", @chef.chefname
    assert_match "bibash@example", @chef.email
  end
end

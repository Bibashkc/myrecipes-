require 'test_helper'

class ChefsSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    
  end
  
  test "should get signup path" do 
    get signup_url 
    assert_response :success
  end
  
  test "reject an invalid signup" do 
    get signup_url
    assert_no_difference "Chef.count" do 
      post chefs_url, params: {chef: {chefname: " ", email: " ", password: "password", password_confirmation: " "}}
    end
    assert_template 'chefs/new'
    assert_select 'body'
  end
  
  test "accept valid singup" do
    get signup_url
    assert_difference "Chef.count", 1 do 
      post chefs_url, params: {chef: {chefname: "Bibash", email: "bibashkc@gmail.com", password: "password", password_confirmation: "password"}}
    end
    follow_redirect!
    assert_template 'chefs/show'
    assert_not flash.empty?
  end
end

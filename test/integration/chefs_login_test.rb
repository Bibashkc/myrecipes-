require 'test_helper'

class ChefsLoginTest < ActionDispatch::IntegrationTest
  
  def setup 
    @chef = Chef.create!(chefname: "bibash", email: "bibash@gmail.com", password: "password")
  end
  
  test "invalid login is rejected" do 
    get login_url
    assert_template 'sessions/new'
    post login_url, params: {session: {email: " ", password: " "}}
    assert_template 'sessions/new'
    assert_not flash.empty?
    assert_select "a[href=?]", login_url
    assert_select "a[href=?]", logout_url, count: 0
    get root_url
    assert flash.empty?
  end
  
  test "valid login credentials accepted and begin session" do 
    get login_url
    assert_template 'sessions/new'
    post login_url, params: {session: {email: @chef.email, password: @chef.password}}
    assert_redirected_to @chef
    follow_redirect!
    assert_template 'chefs/show'
    assert_not flash.empty?
    assert_select "a[href=?]", login_url, count: 0
    assert_select "a[href=?]", logout_url
    assert_select "a[href=?]", chef_url(@chef)
    assert_select "a[href=?]", edit_chef_url(@chef)
  end
  
end

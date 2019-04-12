class PagesController < ApplicationController
  def home
    @recipes = Recipe.all.sample(3)
    redirect_to recipes_url if logged_in?
  end
end

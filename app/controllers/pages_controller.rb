class PagesController < ApplicationController
  def home
    redirect_to recipes_url if logged_in?
  end
end

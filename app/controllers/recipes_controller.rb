class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
    render :index
  end
  
  def show
    @recipe = Recipe.find(params[:id])
    render :show
  end
  
  def new
    @recipe = Recipe.new
    render :new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.first
     if @recipe.save
       flash[:errors] = ["Recipe was created successfully"]
       redirect_to recipe_url(@recipe)
     else
       flash.now[:errors] = @recipe.errors.full_messages
       render :new
     end
  end
  
  private
  def recipe_params
    params.require(:recipe).permit(:name, :description)
  end
  
end

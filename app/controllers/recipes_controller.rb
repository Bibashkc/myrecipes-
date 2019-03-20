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
       flash[:success] = ["Recipe was created successfully"]
       redirect_to recipe_url(@recipe)
     else
       flash.now[:errors] = @recipe.errors.full_messages
       render :new
     end
  end
  
  def edit
    @recipe = Recipe.find(params[:id])
    render :edit
  end
  
  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update_attributes(recipe_params)
      redirect_to recipe_url(@recipe)
      flash[:success] = ["Recipe was updated successfully"]
    else
      flash.now[:errors] = @recipe.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:success] = ["Successfuly deleted!"]
    redirect_to recipes_url
  end
  
  private
  def recipe_params
    params.require(:recipe).permit(:name, :description)
  end
  
end

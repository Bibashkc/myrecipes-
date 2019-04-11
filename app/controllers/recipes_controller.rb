class RecipesController < ApplicationController
  
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only:[:edit, :destroy, :update]
  
  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 5)
    render :index
  end
  
  def show
    set_recipe
    render :show
  end
  
  def new
    @recipe = Recipe.new
    render :new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_chef
     if @recipe.save
       flash[:success] = ["Recipe was created successfully"]
       redirect_to recipe_url(@recipe)
     else
       flash.now[:errors] = @recipe.errors.full_messages
       render :new
     end
  end
  
  def edit
    set_recipe
    render :edit
  end
  
  def update
   set_recipe
    if @recipe.update_attributes(recipe_params)
      redirect_to recipe_url(@recipe)
      flash[:success] = ["Recipe was updated successfully"]
    else
      flash.now[:errors] = @recipe.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    set_recipe
    @recipe.destroy
    flash[:success] = ["Successfuly deleted!"]
    redirect_to recipes_url
  end
  
  private
  
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
  
  def recipe_params
    params.require(:recipe).permit(:name, :description)
  end
  
  def require_same_user
    if current_chef != @recipe.chef
      flash[:errors] = ["You can only delete or edit your own recipes"]
      redirect_to recipes_url
    end
  end
  
end

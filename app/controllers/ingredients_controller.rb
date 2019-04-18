class IngredientsController < ApplicationController
  before_action :require_admin, except: [:show, :index]
  def new
    @ingredient = Ingredient.new
  end
  
  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:success] = ["Ingredient was successfully created"]
      redirect_to ingredient_url(@ingredient)
    else
      flash.now[:errors] = @ingredient.errors.full_messages
      render :new
    end
  end
  
  def edit 
    @ingredient = Ingredient.find(params[:id])
  end
  
  def update
    @ingredient = Ingredient.find(params[:id])
    if @ingredient.update(ingredient_params)
      flash[:success] = ["Ingredient name was updated successfully"]
      redirect_to @ingredient
    else
      flash.now[:errors] = @ingredient.errors.full_messages
      render :edit
    end
  end
  
  def show 
    @ingredient = Ingredient.find(params[:id])
    @ingredient_recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 5)
    render :show
  end
  
  def index
    @ingredients = Ingredient.paginate(page: params[:page], per_page: 5)
  end
  
  private
  
  def ingredient_params
    params.require(:ingredient).permit(:name)
  end
  
  def require_admin
    if !logged_in? ||(logged_in? && !current_chef.admin?) 
      flash[:errors] = ["Only admin users can perform that action"]
      redirect_to ingredients_url
    end
  end
  
end

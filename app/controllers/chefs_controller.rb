class ChefsController < ApplicationController
  
  before_action :require_same_user, only:[:edit,:update,:destroy]
  
  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 4)
    render :index
  end
  
  def new
    @chef = Chef.new
    render :new
  end
  
  def create
    @chef = Chef.new(chef_params)
    if @chef.save 
      session[:chef_id] = @chef.id
      flash[:success] = ["Welcome #{@chef.chefname} to MyRecipes App!"]
      redirect_to chef_path(@chef)
    else
      flash.now[:errors] = @chef.errors.full_messages
      render 'new'
    end
  end
  
  def show
    @chef = Chef.find(params[:id])
    @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 4)
    render :show
  end
  
  def edit
    @chef = Chef.find(params[:id])
    render :edit
  end
  
  def update
    @chef = Chef.find(params[:id])
    if @chef.update(chef_params)
      flash[:success] = ["Your account has been succesfully updated!"]
      redirect_to @chef
    else
      flash.now[:errors] = @chef.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @chef = Chef.find(params[:id])
    @chef.destroy
    flash[:success] = ["chef and all associated recipes haven been deleted!"]
    redirect_to chefs_url
  end
  
  private
  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end
  
  def require_same_user
    if current_chef != @chef
      flash[:errors] = ["You can only edit and delete your own account"]
      redirect_to chefs_url
    end
  end
end

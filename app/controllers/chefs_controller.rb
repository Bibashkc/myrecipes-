class ChefsController < ApplicationController
  def new
    @chef = Chef.new
    render :new
  end
  
  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = ["Welcome #{@chef.chefname} to MyRecipes App!"]
      redirect_to chef_path(@chef)
    else
      flash.now[:errors] = @chef.errors.full_messages
      render 'new'
    end
  end
  
  def show
    @chef = Chef.find(params[:id])
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
  
  private
  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end
end

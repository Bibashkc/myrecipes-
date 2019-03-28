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
  
  private
  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end
end

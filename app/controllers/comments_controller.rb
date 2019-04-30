class CommentsController < ApplicationController
  before_action :require_user
  
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = Comment.new(comment_params)
    @comment.recipe_id = @recipe.id
    @comment.chef_id = current_chef.id
    if @comment.save
      ActionCable.server.broadcast "comments", render(partial: 'comments/comment', object: @comment)
      # flash[:success] = ["Comment was created successfully"]
      # redirect_to recipe_url(@recipe)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to :back
    end
  end
  private
  
  def comment_params
    params.require(:comment).permit(:description)
  end
end

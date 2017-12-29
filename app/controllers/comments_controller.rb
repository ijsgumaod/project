class CommentsController < ApplicationController

  def create
    #@post = @user.posts.find(params[:post_id])
    @post = Post.find(params[:post_id])

    if @comment = @post.comments.create(comment_params)
      @comment.user_id = current_user.id
      @comment.save
      flash[:success] = "Successfully created..."
      redirect_to user_post_path(current_user.id, @post.id)
    else
      flash[:warning] = "Unsuccessful..."
      render 'new'
    end
  end

  def destroy
    @user = User.find(current_user.id)
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @post.comments.create(comment_params)
      flash[:success] = "Successfully deleted..."
      redirect_to user_post_path(@post)
    else
      flash[:warning] = "Unsuccessful..."
      render 'new'
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end

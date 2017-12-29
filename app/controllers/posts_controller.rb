class PostsController < ApplicationController
  def index
    @post = Post.all
    @user = User.all
    #@post = @post.order("created_at DESC")
    #@user_thumb = current_user.find(Post.find_by(user_id).avatar.thumb.url if User.find(@post.user_id).avatar?
  end

  def new
    #@post = Post.new
    #@post = @user.posts.build(user: current_user) if logged_in?
    @post = Post.new
  end

  def create
    @user = User.find(current_user.id)

    if @user.posts.create(post_params)
      flash[:success] = "New Post created!"
      redirect_to user_posts_path
    else
      flash[:warning] = "Unsuccessful.."
      redirect_to new_user_post_path
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @user = User.find(current_user.id)
    @post = @user.posts.find(params[:id])

    if @post.update_attributes(post_params)
      flash[:success] = "Post successfully updated!"
      redirect_to user_posts_path(@post)
    else
      flash[:danger] = "Operation incomplete!"
      render 'edit'
    end
  end

  def show
    #@user = User.find(current_user.id)
    @post = Post.find(params[:id])
  end

  def destroy
    @user = User.find(current_user.id)
    @post = @user.posts.find(params[:id])

    if @post.destroy
      flash[:success] = "Post deleted..."
      redirect_to user_posts_path(current_user.id)
    else
      flash[:warning] = "Unsuccessful..."
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :body, :picture)
    end
end

class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def index
    @user = User.all
    respond_to do |format|
      format.html
      format.json { render :json => @user }
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(params[:user][:email], params[:user][:password])
      respond_with(@user)
      flash[:success] = 'Welcome!'
      redirect_to user_posts_path(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Successfully Updated!"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @user }
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :avatar, :remove_avatar)
    end
end

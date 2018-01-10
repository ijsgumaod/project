class AdminsController < ApplicationController
  before_action :admin_only, :except => :show

  def index
    @user = User.all
    respond_to do |format|
      format.html
      format.json { render :json => @user }
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])

    if @user.destroy
      flash[:success] = "User deleted!"
      redirect_to user_admins_path(current_user.id)
    else
      flash[:warning] = "Unsuccessful..."
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_role)
      flash[:notice] = "Success!"
      redirect_to user_admins_path(current_user)
    else
      flash[:danger] = "Unsuccessful!"
      render 'edit'
    end
  end

  private
    def admin_only
      unless current_user.admin?
        flash[:danger] = "Unauthorized User!"
        redirect_to user_posts_path(current_user)
      end
    end

    def user_role
      params.require(:user).permit(:role)
    end
end

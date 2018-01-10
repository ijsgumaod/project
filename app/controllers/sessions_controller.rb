class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user_list = User.all
    respond_to do |format|
      format.html
      format.json { render :json => @user_list }
    end
  end

  def create
    if login(params[:email], params[:password], params[:remember_me])

      flash[:success] = 'Welcome Back!'
      redirect_back_or_to user_posts_path(current_user)
    else
      flash[:warning] = "Email and/or Password is incorrect."
      render 'new'
    end
  end

  def destroy
    logout
    flash[:success] = 'Come back again!'
    redirect_to new_session_path
  end
end

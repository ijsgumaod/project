class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  private
    def not_authenticated
      flash[:warning] = "You have to authenticate to access this page."
      redirect_to root_path
    end

    #helper_method :current_users_list
     #protected
     #def current_users_list
    #   current_users.map {|u| u.username}.join(", ")
     #end
end

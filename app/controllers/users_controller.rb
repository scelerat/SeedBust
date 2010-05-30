class UsersController < ApplicationController
  
  layout 'standard'
  def home
      @user = User.new()
      @user.fb_first_name = "Frank"
      @user.fb_last_name = "Williams"
      session[:user] = @user
  end

  def facebook
    redirect_to oauth_authorize_path
  end
  
  def foursquare
    if session[:user] 
      redirect_to "/seeds/show"
    end
  end

  def profile
  end
end

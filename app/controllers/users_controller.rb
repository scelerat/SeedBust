class UsersController < ApplicationController
  
  layout 'standard'
  def home
  end

  def facebook
    redirect_to oauth_authorize_path
  end

  def profile
  end
end

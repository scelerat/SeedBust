class UsersController < ApplicationController
  def home
  end

  def facebook
    redirect_to oauth_authorize_path
  end

  def profile
  end

end

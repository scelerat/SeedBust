class OauthController < ApplicationController
  def start
    redirect_to client.web_server.authorize_url(
      :redirect_uri => oauth_callback_url
    )
  end

  def callback
    require 'models/user.rb'
    require 'json'
    access_token = client.web_server.get_access_token(
      params[:code], :redirect_uri => oauth_callback_url
    )

    user_json = access_token.get('/me')
    # in reality you would at this point store the access_token.token value as well as 
    # any user info you wanted
    user_record = JSON.parse(user_json)
    
    user = User.find_by_fb_id(user_record["id"])
    if user.nil? then
      user = User.new
      user.fb_id          = user_record["id"]
      user.fb_first_name  = user_record["first_name"]
      user.fb_last_name   = user_record["last_name"]
      user.fb_link        = user_record["link"]
      user.save
    end
    session[:user] = user
    session[:access_token] = access_token.token
    
    redirect_to :controller => :users, :action => :home
    # render :json => user_json
  end

  protected

  def client
    @client ||= OAuth2::Client.new(
      FACEBOOK_APPLICATION_ID, FACEBOOK_SECRET, :site => 'https://graph.facebook.com'
    )
  end
end
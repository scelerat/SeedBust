class OauthController < ApplicationController
  def start
    # redirect_to client.web_server.authorize_url(
    #   :redirect_uri => oauth_callback_url
    # )
    @request_token =  client.get_request_token
    session[:request_token] = @request_token
    logger.debug @request_token.authorize_url
    redirect_to @request_token.authorize_url
  end

  def callback
    require 'models/user.rb'
    require 'json'
    
    
    # OAUTH2 / Facebook
    # access_token = client.web_server.get_access_token(
    #   params[:code], :redirect_uri => oauth_callback_url
    # )
    # 
    # user_json = access_token.get('/me')
    # # in reality you would at this point store the access_token.token value as well as 
    # # any user info you wanted
    # user_record = JSON.parse(user_json)
    # logger.debug user_record.to_yaml
    # 
    # user = User.find_by_fb_id(user_record["id"])
    # if user.nil? then
    #   user = User.new
    #   user.fb_id          = user_record["id"]
    #   user.fb_first_name  = user_record["first_name"]
    #   user.fb_last_name   = user_record["last_name"]
    #   user.fb_link        = user_record["link"]
    #   user.save
    # end
    
    @request_token = session[:request_token]
    @access_token = @request_token.get_access_token
    @photos = @access_token.get('/photos.xml')
    
    session[:user] = 'foo'
    session[:access_token] = @access_token
    
    redirect_to :controller => :users, :action => :home
    # render :json => user_json
  end

  protected

  def client
    require 'oauth'
    @client=OAuth::Consumer.new( FOURSQ_KEY, FOURSQ_SECRET, {
          :site => 'http://foursquare.com',
          :path => '/oauth/authorize'
        })
    #@client ||= OAuth2::Client.new(
    #  FOURSQ_KEY, FOURSQ_SECRET, :site => 'http://foursquare.com/oauth/authorize'
    #)
  end
end
class OauthController < ApplicationController
  def start
    # redirect_to client.web_server.authorize_url(
    #   :redirect_uri => oauth_callback_url
    # )
    
    oauth = Foursquare::OAuth.new(FOURSQ_KEY, FOURSQ_SECRET)

    request_token = oauth.request_token.token
    request_secret = oauth.request_token.secret
    
    @request_token = oauth.request_token.token
    @request_secret = oauth.request_token.secret
    
    logger.debug "request_token: #{@request_token}"
    logger.debug "request_secret: #{@request_secret}"
    
    # this is from the 
    # @request_token =  client.get_request_token
    session[:oauth] = oauth
    session[:request_token] = @request_token
    session[:request_secret] = @request_secret
    redirect_to oauth.request_token.authorize_url
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
    
    logger.debug "session[:request_token]: #{session[:request_token]}"
    logger.debug "session[:request_secret]: #{session[:request_secret]}"
    logger.debug "params[:oauth_token]: #{params[:oauth_token]}"
    
    oauth = session[:oauth]
    begin
      @access_token, @access_secret = oauth.authorize_from_request(
                                      oauth.request_token.token, 
                                      oauth.request_token.secret, 
                                      params[:oauth_token])
    rescue OAuth::Unauthorized
      logger.debug "access_token: #{@access_token}"
      logger.debug "access_secret: #{@access_secret}"
      logger.debug "oauth_token: #{@oauth_token}"
      redirect_to :action => :denied
      return
    end
    
    oauth.authorize_from_access(@access_token, @access_secret)
    foursquare = Foursquare::Base.new(oauth)
    
    # find the user from the foursquare data
    
    
    
    session[:user] = 'foo'
    session[:access_token] = @access_token
    session[:foursquare] = foursquare
    
    redirect_to :controller => :users, :action => :home
    # render :json => user_json
  end

  protected

  def client
    require 'rubygems'
    require 'oauth'
    require 'foursquare'
    
    # FOURSQUARE gem / API
    @oauth = Foursquare::OAuth.new(FOURSQ_KEY, FOURSQ_SECRET)
    
    # OAUTH: naive Foursquare
    # @client=OAuth::Consumer.new( FOURSQ_KEY, FOURSQ_SECRET, {
    #       :site => 'http://foursquare.com',
    #       :path => '/oauth/authorize'
    #     })
    
    # OAUTH2: Facebook
    #@client ||= OAuth2::Client.new(
    #  FOURSQ_KEY, FOURSQ_SECRET, :site => 'http://foursquare.com/oauth/authorize'
    #)
  end
end
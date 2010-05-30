class OauthController < ApplicationController
  def start
    redirect_to client.web_server.authorize_url(
      :redirect_uri => oauth_callback_url
    )
  end

  def callback
    access_token = client.web_server.get_access_token(
      params[:code], :redirect_uri => oauth_callback_url
    )

    user_json = access_token.get('/me')
    # in reality you would at this point store the access_token.token value as well as 
    # any user info you wanted
    render :json => user_json
  end

  protected

  def client
    @client ||= OAuth2::Client.new(
      FACEBOOK_APPLICATION_ID, FACEBOOK_SECRET, :site => 'https://graph.facebook.com'
    )
  end
end
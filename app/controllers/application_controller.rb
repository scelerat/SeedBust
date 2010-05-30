# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  layout 'standard'
  
  def current_user
    User.find_by_id(session[:user_id]) if session[:user_id]
  end
  
  def access_token
    session[:access_token]
  end
  
  def logged_in?
    !!current_user
  end
  
  def login_required
    authorized? || access_denied
  end
  
  def authorized?(action = action_name, resource = nil)
    logged_in?
  end
  
  def access_denied
    respond_to do |format|
      format.html do
        store_location
        redirect_to "/oauth/start"
      end
      # format.any doesn't work in rails version < http://dev.rubyonrails.org/changeset/8987
      # Add any other API formats here.  (Some browsers, notably IE6, send Accept: */* and trigger 
      # the 'format.any' block incorrectly. See http://bit.ly/ie6_borken or http://bit.ly/ie6_borken2
      # for a workaround.)
      format.any(:json, :xml) do
        request_http_basic_authentication 'Web Password'
      end
    end
  end
  
  def store_location
    session[:return_to] = request.request_uri
  end
  helper_method :current_user
  helper_method :access_token
  # Include standard authentication routines.
  #require "#{RAILS_ROOT}/vendor/plugins/restful_authentication/authenticated_system.rb"
  #include AuthenticatedSystem
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end

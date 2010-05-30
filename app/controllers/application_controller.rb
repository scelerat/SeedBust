# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  layout 'standard'
  
  def current_user
    session[:user]
  end
  
  def access_token
    session[:access_token]
  end
  helper_method :current_user
  helper_method :access_token
  # Include standard authentication routines.
  #require "#{RAILS_ROOT}/vendor/plugins/restful_authentication/authenticated_system.rb"
  #include AuthenticatedSystem
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end

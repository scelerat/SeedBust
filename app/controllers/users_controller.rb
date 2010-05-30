class UsersController < ApplicationController
  
  # Protect these actions behind an admin login
  # before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  # before_filter :find_user, :only => [:suspend, :unsuspend, :destroy, :purge]
  
  before_filter :login_required, :except => [:home, :refer]
  
  layout 'standard'
  def home
      session[:plant] = nil
      session[:debug] = nil
  end

  def refer
    session[:debug] = params[:id]
    @user = current_user
    @plant = Plant.find_by_id(params[:id])
    if not @plant then
      logger.debug "Somebody tried to get a plant that doesn't exist. id: #{params[:id]}"
      redirect_to "/"
    end
    session[:plant] = @plant
  end

  def facebook
    redirect_to oauth_authorize_path
  end
  
  def foursquare
    if current_user 
      redirect_to "/seeds/show/#{current_user.id}"
    end
  end

  def kill
    users = User.find(:all)
    users.each do |u|
      u.destroy
    end
    redirect_to "/"
  end

  def sms
      @response = ACCOUNT.request(\
          "/2008-08-01/Accounts/ACd68795defff7cfda994cfd09d6895fed/SMS/Messages", \
          "POST", { \
            "To" =>"415-760-8666", \
            "From" =>"415 366-6417", \
            "Body" =>"George sent you a new seed with SeedBust."})
      @response.body
      @response.code
  end
  
  def logout
    session[:user_id] = nil
    session[:userdata] = nil
    session[:oauth] = nil
    session[:user] = nil
    session[:access_token] = nil
    session[:access_secret] = nil
    session[:foursquare] = nil
    redirect_to :action => :home
  end
  # render new.rhtml
    def new
      @user = User.new
    end

    def create
      logout_keeping_session!
      @user = User.new(params[:user])
      @user.register! if @user && @user.valid?
      success = @user && @user.valid?
      if success && @user.errors.empty?
        redirect_back_or_default('/')
        flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
      else
        flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
        render :action => 'new'
      end
    end

    def activate
      logout_keeping_session!
      user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
      case
      when (!params[:activation_code].blank?) && user && !user.active?
        user.activate!
        flash[:notice] = "Signup complete! Please sign in to continue."
        redirect_to '/login'
      when params[:activation_code].blank?
        flash[:error] = "The activation code was missing.  Please follow the URL from your email."
        redirect_back_or_default('/')
      else 
        flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
        redirect_back_or_default('/')
      end
    end

    def suspend
      @user.suspend! 
      redirect_to users_path
    end

    def unsuspend
      @user.unsuspend! 
      redirect_to users_path
    end

    def destroy
      @user.delete!
      redirect_to users_path
    end


    def purge
      @user.destroy
      redirect_to users_path
    end

    # There's no page here to update or destroy a user.  If you add those, be
    # smart -- make sure you check that the visitor is authorized to do so, that they
    # supply their old password along with a new one to update it, etc.

    protected
      def find_user
        @user = User.find(params[:id])
    end
end

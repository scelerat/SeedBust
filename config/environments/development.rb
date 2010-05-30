# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

FACEBOOK_APPLICATION_ID   = '127888450571332'
FACEBOOK_API_KEY          = 'fb61f1f46dd3f5224e4b93ce50e3a1b5'
FACEBOOK_SECRET           = 'b2eb443b293f7fd3c93169c037acae07'
FACEBOOK_URL              = 'https://graph.facebook.com'

FOURSQUARE = '' # curl -u PHONE_OR_EMAIL:PASSWORD http://api.foursquare.com/v1/user

SERVER = "seedbust.local/"
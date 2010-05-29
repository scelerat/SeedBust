# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_seedbust_session',
  :secret      => '250cea1ab0950b6243815ad99ecc2cc53f27487d59fb0516f515e11f51c49a0cd5c7b7288ba53eace1f70aeebaa85003df8a5b6b2e6201c25fb3a064a4ee20c3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

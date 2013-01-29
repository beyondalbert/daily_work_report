# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_dailymail_session',
  :secret      => '50508114ba1dffb27598939d653ab0460002beef8992ba0cb7f70b199775bf5fcd32205e97a3a5774aae34dc5a962c5358459503c96e10355e90ba110052c633'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

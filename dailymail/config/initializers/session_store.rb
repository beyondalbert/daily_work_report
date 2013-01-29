# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_dailymail_session',
  :secret      => '00a1e8623452abcbc4173b9578a8e23e05c2e56e903daef988f1cd60f651edbdc2ee705b54539e7c4f6ddf358cb7f28ee13110724fb22c0aaab3deee6083f350'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

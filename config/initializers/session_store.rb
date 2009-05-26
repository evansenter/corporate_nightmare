# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_nightmare_session',
  :secret      => '43603356fa91e79cef3f4be7b6f559fb1bed1fab6b3f74b7ab94770084a66fbdca605454bf254e163b69c8809c2fcad49864b5451c41344bee49154bfffbf94e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

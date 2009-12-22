# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_gat_session',
  :secret      => 'b65dc622ca7e7dfe0d9c8b20f711f551530ed7d725ba81f21f24aa98155636812a8ebf364a66a52f63f991a600d7a1a8933a6f33748a0a9cb4fc458cbf3e1480'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

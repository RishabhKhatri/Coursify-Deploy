# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: '_Coursify_session', domain: "coursify.in"

require 'rack-cas/session_store/rails/active_record'
Rails.application.config.session_store ActionDispatch::Session::RackCasActiveRecordStore, domain: "coursify.in"

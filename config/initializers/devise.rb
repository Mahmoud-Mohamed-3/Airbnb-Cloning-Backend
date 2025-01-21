# config/initializers/devise.rb
Devise.setup do |config|
  # Other Devise configurations...

  # Google OAuth configuration
  config.omniauth :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], scope: "email, profile", prompt: "select_account"
end
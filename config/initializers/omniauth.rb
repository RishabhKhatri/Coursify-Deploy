Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.secrets.google_app_id, Rails.application.secrets.google_app_secret,
    {
      :name => "google",
      :scope => "email, profile",
      :prompt => "select_account",
      :image_aspect_ratio => "original",
      :image_size => 300
    }
    provider :facebook, Rails.application.secrets.facebook_app_id, Rails.application.secrets.facebook_app_secret,
    {
      scope: "email, public_profile",
      display: "popup",
      image_size: {width: 300}
    }
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def not_found
    render file: "#{Rails.root}/public/404.html",  layout: false, status: 404
  end

  def authenticate
    # Only allowing access from home IP address
    not_found unless Rails.env.development? || request.remote_ip == "82.44.245.7"
  end
end

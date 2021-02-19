class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery with: :exception

  def not_found
    render file: "#{Rails.root}/public/404.html",  layout: false, status: 404
  end

  def authenticate
    not_found unless admin_session?
  end
end

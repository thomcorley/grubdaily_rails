module ApplicationHelper
  def admin_session?
    Rails.env.development? || ENV["RAILS_ENVIRONMENT"] == "staging"
      request.remote_ip == "82.44.245.7" || # 128 Ferry Road
      request.remote_ip == "92.28.148.71"   # The Peels
  end
end

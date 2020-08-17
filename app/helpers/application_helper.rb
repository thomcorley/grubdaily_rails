module ApplicationHelper
  def admin_session?
    Rails.env.development? || request.remote_ip == "82.44.245.7"
  end
end

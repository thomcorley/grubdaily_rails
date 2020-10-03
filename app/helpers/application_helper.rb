module ApplicationHelper
  def admin_session?
    Rails.env.development? ||
      request.remote_ip == "82.44.245.7" ||
      request.remote_ip == "92.28.148.71"
  end
end

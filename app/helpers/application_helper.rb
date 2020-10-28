module ApplicationHelper
  def admin_session?
    Rails.env.development? ||
      request.remote_ip == "82.24.100.143" || # 128 Ferry Road
      request.remote_ip == "92.28.148.71"   # The Peels
  end
end

module ApplicationHelper
  def admin_session?
    Rails.env.development? ||
      Rails.env.test? ||
      request.remote_ip == FERRY_ROAD_IP ||
      request.remote_ip == THE_PEELS_IP ||
      request.remote_ip == "86.166.154.226"
  end
end

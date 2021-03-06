module ApplicationHelper
  def admin_session?
    Rails.env.development? ||
      IpAddress.admin.pluck(:ip_address).include?(request.remote_ip)
  end
end

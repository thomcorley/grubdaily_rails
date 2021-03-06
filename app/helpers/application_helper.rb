module ApplicationHelper
  def admin_session?
    Rails.env.development? ||
      Rails.env.test? ||
      IpAddress.admin.pluck(:ip_address).include?(request.remote_ip)
  end
end

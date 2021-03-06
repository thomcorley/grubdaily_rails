class IpAddress < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :ip_address, presence: true, uniqueness: true
end

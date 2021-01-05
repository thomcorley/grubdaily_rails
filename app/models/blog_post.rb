class BlogPost < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :title, length: { maximum: 50 }
end

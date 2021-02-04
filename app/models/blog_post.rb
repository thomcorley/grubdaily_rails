class BlogPost < ApplicationRecord
  include TitleFormatter

  validates :title, presence: true, uniqueness: true
  validates :title, length: { maximum: 50 }

  def image_url
    images.split("\r\n").first
  end

  def content_paragraphs
    content.split("\r\n")
  end

  def publish!
    self.update!(published_at: DateTime.now, published: true)
  end

  def unpublish!
    self.update!(published: false)
  end

  def excerpt
    "#{content.first(140)} ..."
  end

  def permalink
    "/posts/#{url_friendly_title.downcase.split.join("-")}"
  end
end

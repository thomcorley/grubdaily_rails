class BlogPost < ApplicationRecord
  include TitleFormatter

  validates :title, presence: true, uniqueness: true
  validates :title, length: { maximum: 50 }

  def image
    if images.present?
      images.split("\n").first
    else
      url_friendly_title.parameterize
    end
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
    MarkdownConverter.convert("#{content.first(140)} ...")
  end

  def permalink
    "/posts/#{url_friendly_title.downcase.split.join("-")}"
  end

  # TODO: make this a common method
  def rating_value
    [4, 4.5, 5].sample
  end

  # TODO: make this a common method
  def rating_count
    rand(20..98)
  end

  def word_count
    content.split.size
  end

  def url
    "https://www.grubdaily.com#{permalink}"
  end
end

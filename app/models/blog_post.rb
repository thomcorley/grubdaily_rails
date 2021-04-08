class BlogPost < ApplicationRecord
  include TitleFormatter

  validates :title, presence: true, uniqueness: true
  validates :title, length: { maximum: 50 }

  def image
    # TODO: add multiple image handling for blog posts
    # this will involve ensuring all blog posts in the DB
    # do not have any S3 images set on them because otherwise
    # it will look in the assets folder for them.
    #
    # if images.present?
    #   images.split("\n").first
    # else
    #   url_friendly_title.parameterize
    # end

    url_friendly_title.parameterize
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

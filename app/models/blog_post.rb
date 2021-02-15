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

  def json_schema
    JSON.generate({
      "@context": "http://schema.org",
      "@type": "BlogPosting",
      name: title,
      headline: title,
      author: {
        "@type": "Person",
        name: "Tom Corley",
        givenName: "Tom",
        familyName: "Corley",
        jobTitle: "Chef"
      },
      image: image_url,
      datePublished: published_at,
      abstract: summary,
      articleBody: content,
      wordCount: word_count,
      publisher: {
        "@type": "Organization",
        name: "grubdaily",
        logo: {
          "@type": "ImageObject",
          url: "http://www.grubdaily.com/favicon_large.jpg"
        }
      }
    }).html_safe
  end
end

class Entry < ApplicationRecord
  include TitleFormatter

  validates :title, presence: true, uniqueness: true
  validates :title, length: { maximum: 50 }

  scope :published, -> { where(published: true) }

  def self.get(permalink)
    self.class.select{ |recipe| recipe.permalink == "/#{permalink}"}.first
  end

  def content_paragraphs
    content.split("\n")
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

  def url
    "https://www.grubdaily.com#{permalink}"
  end

  def word_count
    content.split.size
  end

  def rating_value
    [4, 4.5, 5].sample
  end

  def rating_count
    rand(20..98)
  end
end

class Entry < ApplicationRecord
  include TitleFormatter

  validates :title, presence: true, uniqueness: true
  validates :title, length: { maximum: 50 }

  def self.get(permalink)
    self.class.select{ |recipe| recipe.permalink == "/#{permalink}"}.first
  end

  def content_paragraphs
    content.split("\n")
  end
end

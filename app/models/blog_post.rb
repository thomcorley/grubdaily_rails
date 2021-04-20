class BlogPost < Entry
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

  def permalink
    "/posts/#{url_friendly_title.downcase.split.join("-")}"
  end
end

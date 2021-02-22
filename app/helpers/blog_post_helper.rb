module BlogPostHelper
  def blog_post_json_schema
    JSON.generate({
      "@context": "http://schema.org",
      "@type": "BlogPosting",
      name: @blog_post.title,
      headline: @blog_post.title,
      author: {
        "@type": "Person",
        name: "Tom Corley",
        givenName: "Tom",
        familyName: "Corley",
        jobTitle: "Chef"
      },
      image: asset_path(@blog_post.image),
      datePublished: @blog_post.published_at,
      abstract: @blog_post.summary,
      articleBody: @blog_post.content,
      wordCount: @blog_post.word_count,
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

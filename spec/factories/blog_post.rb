FactoryBot.define do
  factory :blog_post, class: BlogPost do
    title { "My first blog post" }
    summary { "A very special post about something very dear to my heart" }
    content { "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry" }
    images { "my-first-blog-post\nsecond-picture" }
    tags { "these, are, test, tags" }
    published { true }
    published_at { Date.today }
  end
end

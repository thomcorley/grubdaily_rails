require "rails_helper"

RSpec.describe BlogPost do
  describe "#image" do
    let(:blog_post) { FactoryBot.create(:blog_post) }

    context "when it has no images" do
      before { blog_post.update(images: nil) }

      it "gets the primary image path from the title" do
        expected_primary_image = blog_post.url_friendly_title.parameterize
        expect(blog_post.image).to eq expected_primary_image
      end
    end

    context "when it has an image that is an empty string" do
      before { blog_post.update(images: "") }

      it "gets the primary image path from the title" do
        expected_primary_image = blog_post.url_friendly_title.parameterize
        expect(blog_post.image).to eq expected_primary_image
      end
    end
  end
end

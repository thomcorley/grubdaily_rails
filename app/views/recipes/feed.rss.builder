xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.channel do
    xml.title "Recipe List"
    xml.description "Recipe List"
    xml.link "https://www.grubdaily.com"
    @recipes.each do |recipe|
      xml.item do
        xml.title recipe.title
        xml.link "https://www.grubdaily.com#{recipe.permalink}"
        xml.image "https://www.grubdaily.com#{asset_path(recipe.image)}"
        xml.description recipe.summary
        xml.category "Recipe"
        xml.pubDate recipe.published_at.strftime("%a, %e %b %Y %H:%M:%S %z")
      end
    end
  end
end

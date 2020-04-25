class RecipeImportsController < ApplicationController

  def new
    @recipe_import = RecipeImport.new
    @recipe_import.content = params[:content]
  end

  def create
    content = params[:content]

    importer = RecipeImporter.new(content)
    recipe_id = importer.save_recipe

    importer.save_ingredients(recipe_id)
    importer.save_method_steps(recipe_id)

    redirect_to recipe_path(recipe_id)
  end

  # Using Nokogiri to screen-scrape the recipe info
  # from the HEAD of the file. However, we're missing the
  # tags and the introduction paragraphs from this.
  def scrape_recipes_from_blog
    # Get the URLs of all the recipes into an array
    sitemap = HTTParty.get("https://www.grubdaily.com/sitemap.xml")
    sitemap_hash = Hash.from_xml(sitemap.body).deep_symbolize_keys
    recipe_urls = sitemap_hash[:urlset][:url].map{ |i| i[:loc] }

    # Visit each URL and get the schema information from the HEAD
    # of the webpage
    recipe_urls.first(3).each do |url|
      full_page = Nokogiri::HTML(HTTParty.get(url))
      recipe_json = full_page.at("script[type='application/ld+json']").content
      recipe_hash = JSON.parse(recipe_json).deep_symbolize_keys
      puts recipe_hash[:name]
    end
  end
end

module RecipeHelper
  def serves_or_makes_text
    if @recipe.serves
      "Serves: #{@recipe.serves}"
    elsif @recipe.makes
      "Makes #{@recipe.makes} #{@recipe.makes_unit}"
    else
      ""
    end
  end

  def recipe_json_schema
    JSON.generate({
      "@context": "http://schema.org",
      "@type": "Recipe",
      name: @recipe.title,
      author: {
        "@type": "Person",
        name: "Tom Corley",
        givenName: "Tom",
        familyName: "Corley",
        jobTitle: "Chef"
      },
      image: asset_path(@recipe.image),
      datePublished: @recipe.created_at,
      totalTime: @recipe.total_time,
      recipeYield: @recipe.serves_or_makes,
      description: @recipe.summary,
      aggregateRating: {
        "@type": "AggregateRating",
        ratingValue: @recipe.rating_value,
        ratingCount: @recipe.rating_count
      },
      recipeIngredient: @recipe.ingredients_array,
      recipeInstructions: @recipe.method_steps_array,
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

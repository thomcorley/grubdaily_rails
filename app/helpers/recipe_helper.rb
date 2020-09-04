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
end

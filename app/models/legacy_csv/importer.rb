class LegacyCsv::Importer

  CONNECTIVES = ["and", "with", "a", "la", "of", "for", "au", "the", "le"]

  def import
    # TODO: Need to select only the recipes which have ingredients, method, serves or makes,
    # introduction, and an image. Select the posts which have images in S3 first, then select from that list.
    formatter = LegacyCsv::Formatter.new("lib/csv")

    # Get a list of info for all the recipes
    # Select only the ones that have :introduction, :serves/:makes, ingredients and method_steps
    ids_of_recipes_with_images = LegacyCsv::RecipesWithImages::LIST
    ids_of_complete_recipes = []

    ids_of_recipes_with_images.each do |id|
      info = formatter.get_recipe_info(id)
      ingredients = formatter.get_ingredients(id)
      method_steps = formatter.get_method_steps(id.to_i)

      if method_steps.first[:step] &&
        ingredients.reject{|i| i.is_a?(Integer)}.first != "" &&
        info[:serves] || info[:makes] &&
        info[:introduction]

        ids_of_complete_recipes << id
      end
    end

    titles_and_ids = formatter.get_list_of_titles
    current_filenames = LegacyCsv::CurrentFilenames::LIST

    # Convert the array of currently existing filenames to an array of hashes
    # Keys should be :date and :title
    # Match the date with regex and gsub the title to remove dashes and file extension
    array_of_dates_and_titles = []
    current_filenames.each do |n|
      hash = {}
      date = /20\d{2}-\d{2}-\d{2}/.match(n).to_s
      title = n.sub(date, "").sub("-", "").gsub("-", " ").gsub(".md", "")
      hash[:date] = date
      hash[:title] = title
      array_of_dates_and_titles << hash
    end

    counter = 0

    ids_of_complete_recipes.each do |id|

      info = formatter.get_recipe_info(id)
      ingredients = formatter.get_ingredients(id)
      method_steps = formatter.get_method_steps(id.to_i)

      date = get_date(info[:title], array_of_dates_and_titles)
      snake_case_title = convert_title_for_url(info[:title])
      path = generate_path_from_title(snake_case_title)
      image_url = "https://s3.eu-west-2.amazonaws.com/grubdaily/#{snake_case_title}.jpg"
      
      array_of_tags = info[:tags].split

      info[:serves] ? recipe_yeild = info[:serves] : recipe_yeild = info[:makes]
      rating_value = [4, 4.5, 5].sample
      review_count = rand(10..50)

      recipe_params = {
        title: info[:title], 
        summary: "Test Summary", 
        total_time: nil, 
        introduction: info[:introduction],
        serves: info[:serves],
        makes: info[:makes],
        category: info[:category],
        recipe_type: nil
      }

      recipe = Recipe.new(recipe_params)
      recipe.save validate: false

      ingredient_set = IngredientSet.create!(title: "INSERT_TITLE", position: 1, recipe_id: recipe.id)
      create_ingredient_entries(ingredients, ingredient_set.id)
      create_method_steps(method_steps, recipe.id)

      counter += 1
    end
  end

  def create_ingredient_entries(hash_of_ingredient_entries, ingredient_set_id)
    hash_of_ingredient_entries.each do |i|
      params = {
        quantity: i[:quantity],
        unit: i[:unit],
        size: i[:size],
        modifier: i[:modifier],
        original_string: i[:original_string],
        ingredient_set_id: ingredient_set_id
      }

      ingredient_entry =  IngredientEntry.create!(params)
    end
  end

  def create_method_steps(hash_of_method_steps, recipe_id)
    hash_of_method_steps.each do |m|
      params = {
        position: m[:number],
        description: m[:step],
        recipe_id: recipe_id
      }

      MethodStep.create!(params)
    end
  end

  private

  # Take a recipe title and return the date for that recipe
  # Need to downcase the title and sub out the punctuation
  # Look this title up in the array_of_dates_and_titles, return the date
  def get_date(recipe_title, array)
    title = recipe_title.downcase.gsub(",", "").gsub("\'", "")
    recipe = array.select{|r| r[:title] == title}.first
    recipe[:date]
  end

  def convert_title_for_url(recipe_title)
    title_for_url = recipe_title.downcase.gsub(",", "").gsub("\'", "").gsub(" ", "_")
    title_for_url
  end

  def generate_path_from_title(snake_case_title)
    title_array = snake_case_title.split("_")
    stripped_title = title_array.reject{|i| CONNECTIVES.include?(i)}
    stripped_title.join("_").prepend("/")
  end
end
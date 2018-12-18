class LegacyYaml::Importer
  YAML_PATH = "lib/yaml_recipes"

  def import
    # TODO: read through the files in the YAML folder and import them

    yaml_files.each do |yaml|
      importer = RecipeImporter.new(yaml)
      recipe_id = importer.save_recipe

      importer.save_ingredients(recipe_id)
      importer.save_method_steps(recipe_id)
      importer.save_tags(recipe_id)
    end
  end
end
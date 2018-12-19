class LegacyYaml::Importer
  YAML_PATH = "lib/yaml_recipes/"

  def import
    filenames = Dir.entries(YAML_PATH)

    filenames.each do |filename|
      next unless filename.match?(".yaml")

      yaml = YAML.load_file(YAML_PATH + filename)
      importer = RecipeImporter.new(yaml)
      recipe_id = importer.save_recipe

      importer.save_ingredients(recipe_id)
      importer.save_method_steps(recipe_id)
      importer.save_tags(recipe_id)
    end
  end
end
class LegacyCsv::Helper

	def initialize
		@recipes = Recipe.all
	end

	def hash_of_corrected_times 
		{
			"Curried Parsnip Soup"=>"PT40M",
			"Puerco Pibil"=>"PT12H",
			"Spaghetti Carbonara"=>"PT25M",
			"Cranachan"=>"PT40M",
			"Crab Salad"=>"PT6H",
			"Stars and Stripes Bagel"=>"PT15M",
			"Roast Garlic Soup"=>"PT1H20M",
			"Cullen Skink"=>"PT1H",
			"Aubergine, Tomato, Parmesan"=>"PT4H",
			"Roasted Mushroom Soup"=>"PT8H",
			"Stuffed Saddle of Lamb"=>"PT1H30M",
			"Roast Pork Fillet, Grain Mustard Sauce"=>"PT1H20M",
			"Arbroath Smoky"=>"PT40M",
			"Pasta Puttanesca"=>"PT9H",
			"Chocolate Mousse"=>"PT7H",
			"Chicken and Coriander Broth"=>"PT4H",
			"Chicken and Pancetta"=>"PT2H",
			"Leek and Roquefort Quiche"=>"PT2D",
			"Hummus"=>"PT1H",
			"Mum's Tomato Soup"=>"PT1H20M",
			"Spaghetti Bolognese"=>"PT4H",
			"Confit Guineafowl with Lentils"=>"PT10H",
			"Chicken Confit with Lemon Dressing"=>"PT10H",
			"Barley Risotto with Chicken"=>"PT1H20M",
			"Salmon and Hollandaise"=>"PT1H",
			"Duck Rillettes"=>"PT14H",
			"Raspberry Cordial"=>"PT45M",
			"Pancakes"=>"PT2H30M",
			"Steak Tartare"=>"PT30M",
			"Lamb Bolognese"=>"PT3H",
			"Chocolate and Raspberry Brownies"=>"PT1H20M",
			"Asian Noodle Soup"=>"PT9H",
			"Apple Tarte Tatin"=>"PT40M",
			"Ricotta"=>"PT6H",
			"Red Onion Chutney"=>"PT5H",
			"Porridge Oats and Banana Cake"=>"PT1H",
			"Chicken Caesar Salad"=>"PT1H20M",
			"Chicken and Smoked Ham Pie"=>"PT4H",
			"Tomato Concasse and Prawn Spaghetti"=>"PT1H",
			"Slow Cooked Lamb"=>"PT4H",
			"Shepherd's Pie"=>"PT6H",
			"Salmon Tartare"=>"PT30M",
			"Rabbit Liver Parfait"=>"PT12H",
			"Peanut Butter Caramel Shortbread"=>"PT3H",
			"Peanut Butter and Jam Crème Brûlée"=>"PT6H",
			"Mulligatawny Soup"=>"PT6H",
			"Macaroni Cheese"=>"PT1H30M",
			"Granny's Spelt Bread"=>"PT1H",
			"Dry Cured Bacon"=>"PT5D",
			"Coq au Vin"=>"PT36H",
			"Pork Belly, Asparagus and Ale Sauce"=>"PT18H"
		}
	end

	def hash_of_corrected_makes_units
		{
			"Chocolate Mousse"=>"portions",
			"Raspberry Cordial"=>"bottle",
			"Chocolate and Raspberry Brownies"=>"portions",
			"Ricotta"=>"small bowlful",
			"Peanut Butter and Jam Crème Brûlée"=>"brûlées",
			"Dry Cured Bacon"=>"side",
			"Pancakes"=>"pancakes",
			"Red Onion Chutney"=>"jars",
			"Peanut Butter Caramel Shortbread"=>"tray",
			"Granny's Spelt Bread"=>"loaf"
		}
	end

	def create_hash_of_times
		regex = Recipe::TIME_FORMAT_REGEX

		# Need to create a hash of recipe titles and times
		h = Hash.new

		@recipes.each do |recipe|
			puts "Please enter time for the following recipe:"
			puts "#{recipe.title}"
			time = gets.chomp.prepend("PT").upcase
			h[recipe.title] = time
			puts "#{recipe.title}: #{time}"
		end
		h
	end

	def correct_hash
		hash = hash_of_corrected_times
		hash.each do |k,v|
			if v.last.match?(/[0-9]/)
				puts "Please correct time: '#{v}'"
				v = gets.chomp
			end
		end
		hash
	end

	def backfill_times
		hash_of_corrected_times.each do |k,v|
			recipe = Recipe.find_by(title: k)
			recipe.total_time = v
			recipe.save validate: false
		end
	end

	def cleanup_makes 
		@recipes.each do |recipe|
			recipe.update_attribute(:makes, nil) if recipe.serves
		end
	end

	def create_hash_of_makes_units
		# Need to create a hash of recipe titles and times
		h = Hash.new

		@recipes.each do |recipe|
			if recipe.makes
				puts "Please enter makes unit for the following recipe:"
				puts "#{recipe.title}"
				print "#{recipe.makes} "
				makes_unit = gets.chomp
				h[recipe.title] = makes_unit
			end
		end
		h
	end

	def backfill_makes_units
		hash_of_corrected_makes_units.each do |k,v|
			recipe = Recipe.find_by(title: k)
			recipe.makes_unit = v
			recipe.save!
		end
	end








end
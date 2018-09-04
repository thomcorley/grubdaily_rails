def create_hash_of_times
	recipes = Recipe.all;nil
	regex = Recipe::TIME_FORMAT_REGEX

	# Need to create a hash of recipe titles and times
	h = Hash.new

	recipes.each do |recipe|
		puts "Please enter time for the following recipe:"
		puts "#{recipe.title}"
		time = gets.chomp.prepend("PT").upcase
		h[recipe.title] = time
		puts "#{recipe.title}: #{time}"
	end
	h
end

def correct_hash(hash)
	hash.each do |k,v|
		if v.last.match?(/[0-9]/)
			puts "Please correct time: '#{v}'"
			v = gets.chomp
		end
	end
	hash
end

def backfill_times(hash_of_times)
	hash_of_times.each do |k,v|
		recipe = Recipe.find_by(title: k)
		recipe.total_time = v
		
		if recipe.total_time.last.match?(/[0-9]/)
			puts "Please correct time: '#{recipe.total_time}'"
			recipe.total_time = gets.chomp
			recipe.save validate: false
		end
	end
end

hash_of_corrected_times = {"Curried Parsnip Soup"=>"PT40M", "Puerco Pibil"=>"PT12H", "Spaghetti Carbonara"=>"PT25M", "Cranachan"=>"PT40M", "Crab Salad"=>"PT6H", "Stars and Stripes Bagel"=>"PT15M", "Roast Garlic Soup"=>"PT1H20M", "Cullen Skink"=>"PT1H", "Aubergine, Tomato, Parmesan"=>"PT4", "Roasted Mushroom Soup"=>"PT8H", "Stuffed Saddle of Lamb"=>"PT1H30", "Roast Pork Fillet, Grain Mustard Sauce"=>"PT1H20", "Arbroath Smoky"=>"PT40M", "Pasta Puttanesca"=>"PT9H", "Chocolate Mousse"=>"PT7H", "Chicken and Coriander Broth"=>"PT4H", "Chicken and Pancetta"=>"PT2H", "Leek and Roquefort Quiche"=>"PT2D", "Hummus"=>"PT1H", "Mum's Tomato Soup"=>"PT1H20", "Spaghetti Bolognese"=>"PT4H", "Confit Guineafowl with Lentils"=>"PT10H", "Chicken Confit with Lemon Dressing"=>"PT10H", "Barley Risotto with Chicken"=>"PT1H20", "Salmon and Hollandaise"=>"PT1H", "Duck Rillettes"=>"PT14H", "Raspberry Cordial"=>"PT45M", "Pancakes"=>"PT2H30M", "Steak Tartare"=>"PT30M", "Lamb Bolognese"=>"PT3H", "Chocolate and Raspberry Brownies"=>"PT1H20M", "Asian Noodle Soup"=>"PT9H", "Apple Tarte Tatin"=>"PT40M", "Ricotta"=>"PT6H", "Red Onion Chutney"=>"PT5H", "Porridge Oats and Banana Cake"=>"PT1H", "Chicken Caesar Salad"=>"PT1H20M", "Chicken and Smoked Ham Pie"=>"PT4H", "Tomato Concasse and Prawn Spaghetti"=>"PT1H", "Slow Cooked Lamb"=>"PT4", "Shepherd's Pie"=>"PT6H", "Salmon Tartare"=>"PT30M", "Rabbit Liver Parfait"=>"PT12H", "Peanut Butter Caramel Shortbread"=>"PT3H", "Peanut Butter and Jam Crème Brûlée"=>"PT6", "Mulligatawny Soup"=>"PT6H", "Macaroni Cheese"=>"PT1H30M", "Granny's Spelt Bread"=>"PT1H", "Dry Cured Bacon"=>"PT5D", "Coq au Vin"=>"PT36H", "Pork Belly, Asparagus and Ale Sauce"=>"PT18H"}
class IngredientEntryProcessor

	SIZES = %w(small medium large generous)

	UNIT_REGEX = /[0-9]+([a-z]+)\s/

	SPECIAL_ENTRIES = [
		"vegetable oil, for frying",
		"sea salt and freshly cracked black pepper",
		"sea salt and cracked black pepper"
	]

	def initialize(ingredient_entry_string, ingredient_set_id)
		@ingredient_entry_string = ingredient_entry_string
		@ingredient_set_id = ingredient_set_id
	end

	# Returns a hash of params to create an IngredientEntry
	def parse
		{
			quantity: get_quantity, 
			unit: get_unit,
			size: get_size,
			modifier: get_modifier,
			original_string: @ingredient_entry_string,
			ingredient_set_id: @ingredient_set_id
		}
	end

	# This is an array of the components of the entry string
	# split on spaces, minus the modifier
	def entry_array
		a = @ingredient_entry_string.split(",").first.split
		a.delete("of")
		return a
	end

	def get_modifier
		if @ingredient_entry_string.match(/(\(.+\))/)
			return @ingredient_entry_string.match(/(\(.+\))/)[1]
		end

		array = @ingredient_entry_string.split(",")
		array.count > 1 ? array.last.strip : nil		
	end

	def get_quantity
		return 1 if entry_array.first == "a"
		return nil if special_exception

		quantity_and_unit = entry_array.select{ |i| i =~ /[0-9]+/ }

		if quantity_and_unit.any?
			quantity_and_unit.first.match(/[0-9]+/)[0].to_i 
		else
			nil
		end
	end

	def get_unit
		return nil if special_exception		
		# If there's a spaced unit (singular or plural) that 
		# matches in the entry string, this is the unit.
		unit = nil
		
		Units::SPACED.each do |i|
			unit = @ingredient_entry_string.match(i)[0] if @ingredient_entry_string.match?(i)
		end
		
		return unit if unit
		
		# Or, the unit might be suffixed to a number.
		# Match this and use a group to separate the unit from the numerical part.
		# Otherwise, there's no unit so just return nil
		matcher = @ingredient_entry_string.match(UNIT_REGEX)
		matcher ? unit = matcher[1] : unit = nil
	end

	def get_size
		return nil if special_exception
		size = nil
		unit = get_unit
		entry_string_minus_unit = @ingredient_entry_string

		if unit
			# Delete the unit from the entry string, plural or singular
			if @ingredient_entry_string.match?(unit + " ") 
				entry_string_minus_unit = @ingredient_entry_string.sub(unit, "")
			else
				entry_string_minus_unit = @ingredient_entry_string.sub(unit.pluralize, "")
			end
		end

		SIZES.each do |s|
			matcher = entry_string_minus_unit.match(s)
			size = matcher[0] if matcher
		end
		size
	end

	def get_ingredient
		string = entry_array.join(" ")
		if get_quantity
			string = string.sub(get_quantity.to_s, "")
			string = string.sub("a ", "")
		end
		string = string.sub(get_size, "") if get_size

		if get_unit
			# TODO! refactor this into a private method

			# ...Delete the unit from the string, plural or singular
			if string.match?(get_unit + " ") 
				string = string.sub(get_unit, "")
			else
				string = string.sub(get_unit.pluralize, "")
			end
		end

		# TODO: change this!!!
		if string =~ /\(/
			string = string.split("(").first
		end
		string.strip.singularize
	end

	def singularize(unit_string)
		if unit_string =~ /clove/
			return "clove"
		else
			unit_string.singularize		
		end
	end

	def special_exception
		SPECIAL_ENTRIES.include?(@ingredient_entry_string)
	end
end
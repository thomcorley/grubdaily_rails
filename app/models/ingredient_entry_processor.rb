class IngredientEntryProcessor

	SIZES = %(small medium large generous)
	UNIT_REGEX = /[0-9]+([a-z]+)\s/

	def initialize(ingredient_entry_string, ingredient_set_id)
		@ingredient_entry_string = ingredient_entry_string
		@ingredient_set_id = ingredient_set_id
	end

	# Returns a hash of params to create an IngredientEntry
	def parse(ingredient_entry_string)
		{
			quantity: quantity(ingredient_entry_string), 
			unit: unit(ingredient_entry_string),
			size: size(ingredient_entry_string),
			modifier: modifier(ingredient_entry_string),
			ingredient_set_id: @ingredient_set_id
		}
	end

	# This is an array of the components of the entry string
	# split on spaces, minus the modifier
	def entry_array
		@ingredient_entry_string.split(",").first.split
	end

	def modifier
		array = @ingredient_entry_string.split(",")
		array.count > 1 ? array.last.strip : nil		
	end

	def quantity
		array = entry_array
		quantity_and_unit = array.select{ |i| i =~ /[0-9]+/ }

		quantity_and_unit.first.match(/[0-9]+/)[0].to_f
	end

	def unit
		# If there's a spaced unit (singular or plural) that 
		# matches in the entry string, this is the unit.
		u = nil
		
		Units::SPACED.each do |i|
			u = @ingredient_entry_string.match(i)[0] if @ingredient_entry_string.match?(i)
		end
		
		return u if u
		
		# Or, the unit might be suffixed to a number.
		# Match this and use a group to separate the unit from the numerical part.
		# Otherwise, there's no unit so just return nil
		matcher = @ingredient_entry_string.match(UNIT_REGEX)
		matcher ? u = matcher[1] : u = nil
	end

	def size

	end

	def ingredient

	end

	def singularize(unit_string)
		if unit_string =~ /clove/
			return "clove"
		else
			unit_string.singularize		
		end
	end
end
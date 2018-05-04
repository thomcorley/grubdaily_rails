class IngredientEntryProcessor

	SIZES = %(small medium large generous)

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
		spaced_unit = Units::SPACED.select{ |i| @ingredient_entry_string.match(i)&[0] }
		unit = nil if spaced_unit == []

		unless unit	
			matcher = @ingredient_entry_string.match(/[0-9]+([a-z]+)\s/)
			matcher ? matcher[1] : nil
		end
	end

	def size

	end

	def ingredient

	end

	def pluralized_unit(unit_string)
		
	end
end
class IngredientEntryTestData
  # [:quantity, :unit, :size, :ingredient, :modifier]
  ENTRIES = [
    {
      original_string: "1 carrot",
      # [:quantity, :unit, :size, :ingredient, :modifier]
      params: [1, nil,  nil, "carrot", nil]
    },
    {
      original_string: "100 g plain flour",
      # [:quantity, :unit, :size, :ingredient, :modifier]
      params: [100, "g",  nil, "plain flour", nil]
    },
    {
      original_string: "10 g carrot, diced",
      # [:quantity, :unit, :size, :ingredient, :modifier]
      params: [10, "g",  nil, "carrot", "diced"]
    },
    {
      original_string: "25 large tomatoes, peeled and chopped",
      # [:quantity, :unit, :size, :ingredient, :modifier]
      params: [25, nil,  "large", "tomatoes", "peeled and chopped"]
    },
    {
      original_string: "3 handfuls basil, leaves picked",
      # [:quantity, :unit, :size, :ingredient, :modifier]
      params: [3, "handful",  nil, "basil", "leaves picked"]
    },
    {
      original_string: "3 large cloves garlic, chopped",
      # [:quantity, :unit, :size, :ingredient, :modifier]
      params: [3, "large clove",  nil, "garlic", "chopped"]
    },
    {
      original_string: "vegetable oil, for frying",
      # [:quantity, :unit, :size, :ingredient, :modifier]
      params: [nil, nil,  nil, "vegetable oil, for frying", nil]
    },
    {
      original_string: "2 small cloves garlic",
      # [:quantity, :unit, :size, :ingredient, :modifier]
      params: [2, "small clove",  nil, "garlic", nil]
    },
    {
      original_string: "750 g cavolo nero",
      # [:quantity, :unit, :size, :ingredient, :modifier]
      params: [750, "g",  nil, "cavolo nero", nil]
    },
    {
      original_string: "1 tsp extra virgin olive oil",
      # [:quantity, :unit, :size, :ingredient, :modifier]
      params: [1, "tsp",  nil, "extra virgin olive oil", nil]
    },
    {
      original_string: "1 pinch ground asafoetida",
      # [:quantity, :unit, :size, :ingredient, :modifier]
      params: [1, "pinch",  nil, "ground asafoetida", nil]
    },
    {
      original_string: "sea salt and freshly cracked black pepper",
      # [:quantity, :unit, :size, :ingredient, :modifier]
      params: [nil, nil,  nil, "sea salt and freshly cracked black pepper", nil]
    },
    {
      original_string: "1/2 leek",
      # [:quantity, :unit, :size, :ingredient, :modifier]
      params: [0.5, nil,  nil, "leek", nil],
    }
  ]
end

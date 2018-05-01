require 'rails_helper'

RSpec.describe RecipeImporter, type: :model do
	setup do
		content = "title: Bacon and Pea Risotto\r\ntotal_time: PT45M\r\nserves: 2\r\nmakes:\r\ntype: main\r\ncategory: risotto\r\ntags: risotto, bacon, pea, italian\r\nsummary: My favourite springtime risotto; lovely sweet peas combined with salty rich lardons.\r\n\r\nintroduction: \r\n  - The risotto remains one of my regular weeknight meals. It's quick to prepare and, to make a plain _risotto bianco_, requires only a few basic ingredients. It's what I call a \"store cupboard\" meal, meaning that the ingredients it comprises all keep for a long time, either in the fridge or the cupboard, so you can always keep them in stock, waiting to be made into a delicious risotto at a moment's notice.\r\n  - My [winter risotto](https://www.grubdaily.com/risotto-winter-greens) was essentially just a plain risotto with some cavolo nero added. I've taken a similar approach here, but with peas, to keep it seasonal. I've added some crisp bacon lardons for good measure. The salty savouriness of the bacon compliments the sweet peas perfectly and it provides a lovely colour contrast, too.\r\n\r\nfirst_ingredient_set:\r\n  INSERT_TITLE:\r\n    - 140g risotto rice\r\n    - 1 small onion, finely chopped\r\n    - 2 cloves garlic, finely chopped\r\n    - 1 glassful dry white wine\r\n    - 60g parmesan cheese, finely grated\r\n    - 40g unsalted butter, chopped\r\n    - 1 tablespoon extra virgin olive oil\r\n    - sea salt and freshly cracked black pepper\r\n    - 200g garden peas, fresh or frozen\r\n    - 150g streaky bacon, cut into lardons\r\n    - 1 litre chicken stock\r\n    - vegetable oil, for frying\r\n\r\nmethod_steps:\r\n- The secret to a good risotto is to stir it _continuously_ as the rice is cooking. This is the only way of getting the ultimate glossy and thick texture. You won't have time to do any prep at the same time so be sure to measure all the ingredients out and get everything chopped before you start.\r\n- Place a medium sized frying pan over a medium heat and put in about ½ tablespoon of vegetable oil. When the oil is hot, add the lardons and fry until crisp. Remove the lardons from the pan and set aside in a bowl. \r\n- Now to start the risotto. Place a medium high-sided pot or pan over a medium high heat and add the olive oil. Wait until the oil is hot, about 1 minute, then add the onion and garlic along with a pinch of salt. Immediately turn down the heat and cook slowly for about 15 minutes, stirring occasionally, until the onions are soft and sweet. This is the _soffrito_.\r\n- Now turn the heat to high and add the rice. Stir vigorously for about 30 seconds to coat the rice in the flavour of the soffrito, then add the wine. Turn the heat to medium-high and continue to stir until all the liquid has gone. From this point the risotto will take about 15 minutes.Continue to add the chicken stock, 1 ladleful at  time, stirring continuously to massage and coax the starch from the rice. This creates the thick sauce of the risotto.\r\n- After about 15 minutes, the risotto should be ready. When you taste a grain of rice, there should be a _slight_ bite to it. If it's still quite hard, continue cooking for a bit longer. Turn the heat off, then add the chilled butter and parmesan gradually, whilst beating the risotto to emulsify it into a lovely creamy texture. If it seems too thick, add a bit of stock. As Giorgio Locatelli says \"It should ripple like waves on the sea\". If you run out of stock, just use boiling water.\r\n- At this point, add half of the peas to the risotto and stir through. Portion the risotto into bowls and garnish with the remaining peas and lardons. Finish with some parmesan shavings.\r\n"
		@importer = RecipeImporter.new(content)
    @importer.populate_fields
	end

  context "the recipe info" do
    it "should have a title" do
      expect(@importer.title).to eq "Bacon and Pea Risotto"
    end

    it "should have a total time" do
      expect(@importer.total_time).to eq "PT45M"
    end

    it "should have a type" do
      expect(@importer.type).to eq "main"
    end

    it "should have a category" do
      expect(@importer.category).to eq "risotto"
    end

    it "should have tags" do
      expect(@importer.tags).to eq "risotto, bacon, pea, italian"
    end        

    it "should have a title" do
      expect(@importer.summary.first(12)).to eq "My favourite"
    end
  end

  context "the introduction" do
  	it "should be present" do 
  		expect(@importer.introduction).to be_present
  	end
  end

  context "ingredient sets" do
  	it "should be present" do
  		expect(@importer.ingredient_sets).to be_present
  	end
  end

  context "the method steps" do
  	it "should be present" do
  		expect(@importer.method_steps).to be_present
  	end  	
	end
end
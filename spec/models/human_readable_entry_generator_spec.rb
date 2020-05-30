require 'rails_helper'
require_relative '../test_data/human_readable_ingredient_entries.rb'

RSpec.describe HumanReadableEntryGenerator,
type: :model do
  describe "#generate" do
    context "parsing a variety of ingredient entry data" do
      test_data = IngredientEntryTestData::ENTRIES

      test_data.each do |hash|
        it "#{hash[:original_string]} has a human readable string equal to the original one" do

          params = {
            quantity: hash[:params][0],
            unit: hash[:params][1],
            size: hash[:params][2],
            ingredient: hash[:params][3],
            modifier: hash[:params][4],
            original_string: hash[:original_string]
          }

          entry = IngredientEntry.create(params)

          expect(described_class.new(entry).generate).to eq(hash[:original_string])
        end
      end
    end
  end
end

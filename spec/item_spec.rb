require './lib/item'
require './lib/auction'
require './lib/attendee'

RSpec.describe Item do
  context "#initialize" do
    item1 = Item.new('Chalkware Piggy Bank')

    it "exists and has attributes" do
      expect(item1).to be_an(Item)
      expect(item1.name).to eq("Chalkware Piggy Bank")
    end
  end
end

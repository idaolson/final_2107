require './lib/item'
require './lib/auction'
require './lib/attendee'

RSpec.describe Auction do
  context "#initialize" do
    item1 = Item.new('Chalkware Piggy Bank')
    item2 = Item.new('Bamboo Picture Frame')
    attendee = Attendee.new(name: 'Megan', budget: '$50')
    auction = Auction.new

    it "exists and has attributes" do
      expect(auction).to be_an(Auction)
      expect(auction.items).to eq([])
    end

    it "adds items to auction" do
      auction.add_item(item1)
      auction.add_item(item2)
      expect(auction.items).to eq([item1, item2])
    end

    it "returns list of item names" do
      expect(auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
    end
  end

  context "iteration 2" do
    item1 = Item.new('Chalkware Piggy Bank')
    item2 = Item.new('Bamboo Picture Frame')
    item3 = Item.new('Homemade Chocolate Chip Cookies')
    item4 = Item.new('2 Days Dogsitting')
    item5 = Item.new('Forever Stamps')
    attendee1 = Attendee.new(name: 'Megan', budget: '$50')
    attendee2 = Attendee.new(name: 'Bob', budget: '$75')
    attendee3 = Attendee.new(name: 'Mike', budget: '$100')
    auction = Auction.new
    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)
    item1.add_bid(attendee2, 20)
    item1.add_bid(attendee1, 22)
    item4.add_bid(attendee3, 50)

    it "returns list of items without bids" do
      expect(auction.unpopular_items).to eq([item2, item3, item5])
      item3.add_bid(attendee2, 15)
      expect(auction.unpopular_items).to eq([item2, item5])
    end

    it "calculates the potential revenue based on the items' highest bids" do
      expect(auction.potential_revenue).to eq(87)
    end
  end
end

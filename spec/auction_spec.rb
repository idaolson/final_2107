require './lib/item'
require './lib/auction'
require './lib/attendee'
require 'date'

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

  context "iteration 3" do
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
    item1.add_bid(attendee1, 22)
    item1.add_bid(attendee2, 20)
    item4.add_bid(attendee3, 50)
    item3.add_bid(attendee2, 15)

    it "returns list of bidders by name" do
      expect(auction.bidders).to eq(["Megan", "Bob", "Mike"])
    end

    it "retruns a hash of attendees and their budgets and what they've bid on" do
      result = {
          attendee1 => {:budget => 50, :items => [item1]},
          attendee2 => {:budget => 75, :items => [item1, item3]},
          attendee3 => {:budget => 100, :items => [item4]}
         }
      expect(auction.bidder_info).to eq(result)
    end
  end

  context "iteration 4" do
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
    item1.add_bid(attendee1, 22)
    item1.add_bid(attendee2, 20)
    item4.add_bid(attendee2, 30)
    item4.add_bid(attendee3, 50)
    item3.add_bid(attendee2, 15)
    item5.add_bid(attendee1, 35)

    # it "has a date" do
    #
    #   auction.date
    #   #=> "24/02/2020"
    #   expect().to eq()
    #
    # end

#     it "closes the auction" do
#       result = {
#         item1 => attendee1,
#         item2 => 'Not Sold',
#         item3 => attendee2,
#         item4 => attendee3,
#         item5 => attendee1
#       }
#       expect(auction.close_auction).to eq(result)
#     end
  end
end

# An Auction will now be created with a date - whatever date the event is created on through the use of `Date.today`. The addition of a date to the event should NOT break any previous tests.  The `date` method will return a string representation of the date - 'dd/mm/yyyy'. We want you to test this in with a date that is IN THE PAST. In order to test the date method in a way that will work today, tomorrow and on any date in the future, you will need to use a stub :)
# - `close_auction` should close bidding and 'sell' items to attendees.
# The method will return a hash with items as the keys,
# and the purchaser of that item as the values. Attendees
# will only purchase items that they can afford
# (their bid is less than their current budget).  If an attendee has bid on multiple items,
# they will purchase the items starting with the most expensive first,
# followed by the next most expensive, etc... while they still have enough money
# in their budget to pay for the item.  If the highest bidder for an item does not
# have enough budget to pay for the item, the next highest bidder will purchase
# the item.

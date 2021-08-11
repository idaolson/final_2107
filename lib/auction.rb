class Auction
  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def item_names
    @items.map { |item| item.name }
  end

  def unpopular_items
    @items.find_all do |item|
      item.bids == {}
    end
  end

  def potential_revenue
    @items.sum do |item|
      if item.current_high_bid == nil
        0
      else
        item.current_high_bid
      end
    end
  end

  def bidders
    @items.flat_map do |item|
      item.bids.keys.map do |key|
       key.name
      end
    end.uniq
  end

  def bidder_info
    bidder_info = {}
    @items.each do |item|
      item.bids.each do |attendee, bid|
        bidder_info[attendee] ||= {
          :budget => attendee.budget,
          :items => []
        }
        bidder_info[attendee][:items] << item
      end
    end
    bidder_info
  end

  # def close_auction
  #   closed = {}
  #
  #   @items.each do |item|
  #     require "pry"; binding.pry
  #     if item.bids == nil
  #       closed[item] = 'Not Sold'
  #     elsif item.current_high_bid
  #
  #
  #     end
  #   end
  # end
end

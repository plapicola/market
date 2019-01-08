class Market

  attr_reader :vendors,
              :name

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map {|vendor| vendor.name}
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.check_stock(item) > 0
    end
  end

  def sorted_item_list
    items = @vendors.map {|vendor| vendor.inventory.keys}
    items.flatten.uniq.sort
  end

  def total_inventory
    @vendors.inject(Hash.new(0)) do |market_inventory, vendor|
      vendor.inventory.each do |item, amount|
        market_inventory[item] += amount
      end
      market_inventory
    end
  end

  def sell(item, quantity)
    # Check if total stock has enough
      # If yes, iterate over vendors and adjust iventories, then return true
      # If not, return false
    return false if total_inventory[item] < quantity
    adjust_vendor_quantities(item, quantity)
    return true
  end

  def adjust_vendor_quantities(item, quantity)
    vendors_that_sell(item).each do |vendor|
      if vendor.check_stock(item) > quantity
        vendor.sell(item, quantity)
        quantity = 0
      else
        quantity -= vendor.check_stock(item)
        vendor.sell(item, vendor.check_stock(item))
      end
    end
  end

end

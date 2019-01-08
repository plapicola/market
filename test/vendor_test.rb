require_relative 'test_helper'

class VendorTest < Minitest::Test

  def setup
    @vendor = Vendor.new("Rocky Mountain Fresh")
  end

  def test_it_exists
    assert_instance_of Vendor, @vendor
  end

  def test_it_has_a_name
    assert_equal "Rocky Mountain Fresh", @vendor.name
  end

  def test_it_has_an_empty_inventory_by_default
    assert_equal ({}), @vendor.inventory
  end

  def test_it_can_check_stock_on_an_item
    assert_equal 0, @vendor.check_stock("Peaches")
  end

  def test_it_can_stock_an_item
    @vendor.stock("Peaches", 30)

    assert_equal 30, @vendor.check_stock("Peaches")
  end

  def test_stocked_items_update_inventory
    @vendor.stock("Peaches", 30)
    @vendor.stock("Tomatoes", 12)

    expected = {"Peaches" => 30, "Tomatoes" => 12}

    assert_equal expected, @vendor.inventory
  end

  def test_it_can_sell_items
    @vendor.stock("Peaches", 30)
    @vendor.stock("Tomatoes", 12)

    expected = {"Peaches" => 12, "Tomatoes" => 12}

    @vendor.sell("Peaches", 18)
    @vendor.sell("Tomatoes", 25)

    assert_equal expected, @vendor.inventory
  end
end

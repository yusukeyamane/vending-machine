require './VendingMachine'
require 'minitest/autorun'

class ProductTest < Minitest::Test
  def setup
    @coke = Beverage.new(name: 'コーラ', price: 120)
  end

  def test_name
    assert_equal 'コーラ', @coke.name
  end

  def test_price
    assert_equal 132, @coke.price
  end
end

class VendingMachineTest < Minitest::Test
  def setup
    beverages = [
      { name: 'コーラ', price: 100 },
      { name: 'お茶', price: 100 },
      { name: 'お水', price: 100 }
    ]
    @products = beverages.map { |b| Beverage.new({ name: b[:name], price: b[:price] }) }
    @sales_maneger = Minitest::Mock.new
    @input = rand(2)
  end

  def test_transaction
    vm = VendingMachine.new(@products, @input, @sales_maneger)
    @sales_maneger.expect(:update, 110, [@products[@input]])
    vm.transaction
    @sales_maneger.verify
  end
end

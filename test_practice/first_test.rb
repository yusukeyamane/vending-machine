require './VendingMachine'
require 'minitest/autorun'

class ProductTest < Minitest::Test
  def test_name
    coke = Beverage.new(name: 'コーラ', price: 120)
    assert_equal 'コーラ', coke.name
  end

  def test_price
    coke = Beverage.new(name: 'コーラ', price: 120)
    assert_equal 132, coke.price
  end
end

class VendingMachineTest < Minitest::Test
  def test_transaction
    beverages = [
      { name: 'コーラ', price: 120 },
      { name: 'お茶', price: 100 },
      { name: 'お水', price: 80 }
    ]
    products = beverages.map { |b| Beverage.new({ name: b[:name], price: b[:price] }) }

    vm = VendingMachine.new(products)
    assert_instance_of(Beverage, vm.transaction)
  end
end

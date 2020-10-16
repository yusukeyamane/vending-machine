require './VendingMachine9'
require 'minitest/autorun'

module ProductInterfaceTest
  def test_implements_the_name_interface
    assert_respond_to(@object, :name)
  end

  def test_implements_the_price_interface
    assert_respond_to(@object, :price)
  end

  def test_responds_to_default_name
    assert_respond_to(@object, :default_name)
  end

  def test_responds_to_default_price
    assert_respond_to(@object, :default_name)
  end
end

module ProductSubClassTest
  def test_responds_to_default_name
    assert_respond_to(@object, :default_name)
  end

  def test_responds_to_default_price
    assert_respond_to(@object, :default_name)
  end
end

class BevarageTest < Minitest::Test
  include ProductInterfaceTest

  def setup
    @coke = @object = Beverage.new(name: 'コーラ', price: 120)
  end

  def test_name
    assert_equal 'コーラ', @coke.name
  end

  def test_price
    assert_equal 132, @coke.price
  end
end

class TabacoTest < Minitest::Test
  include ProductInterfaceTest

  def setup
    @tabaco = @object = Tabaco.new(name: 'テックタバコ', price: 300)
  end

  def test_name
    assert_equal 'テックタバコ', @tabaco.name
  end

  def test_price
    assert_equal 480, @tabaco.price
  end
end

class TicketTest < Minitest::Test
  include ProductInterfaceTest

  def setup
    @tabaco = @object = Ticket.new(name: '渋谷', price: 150)
  end

  def test_name
    assert_equal '渋谷', @tabaco.name
  end

  def test_price
    assert_equal 165, @tabaco.price
  end
end


module VendingMachineBaseInterfaceTest
  def test_responds_to_transaction
    assert_respond_to(@object, :transaction)
  end
end

class VendingMachineTest < Minitest::Test
  include VendingMachineBaseInterfaceTest

  def setup
    @product = Minitest::Mock.new
    @input = 0
    vm = VendingMachine.new([@product], 0)
  end

  def test_transaction

    @product.expect(:name, '第一タバコ')
    @product.expect(:name, '第一タバコ')
    @product.expect(:price, '160')
    @sales_maneger.expect(:update, 160, [@product])
    assert_output(stdout =
      "購入したい商品を以下から選んで、金額を入力してください\n" +
      "[0] 商品名：第一タバコ 税込み価格：160円\n" +
      "第一タバコが選択されました\n") {vm.transaction}
    @sales_maneger.verify
    @product.verify
  end
end

class TicketVendingMachineTest
  include VendingMachineBaseInterfaceTest

  def setup
    @product = Minitest::Mock.new
    @input = 0
    vm = TicketVendingMachine.new([@product], 0)
  end

  def test_transaction
    @product.expect(:name, '渋谷')
    @product.expect(:name, '渋谷')
    @product.expect(:price, 150)
    @sales_maneger.expect(:update, 150, [@product])
    assert_output(stdout =
      "区間を選んで表示された金額を入力してください\n" +
      "[0] 行き先：渋谷 金額：150円\n" +
      "渋谷が選択されました\n") {vm.transaction}
    @sales_maneger.verify
    @product.verify
  end
end

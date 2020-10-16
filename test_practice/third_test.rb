require './VendingMachine'
require 'minitest/autorun'

module ProductInterfaceTest
  def test_implements_the_name_interface
    assert_respond_to(@object, :name)
  end

  def test_implements_the_price_interface
    assert_respond_to(@object, :price)
  end
end

class BevarageTest < Minitest::Test
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

class VendingMachineTest < Minitest::Test
  def setup
    @product = Minitest::Mock.new
    @sales_maneger = Minitest::Mock.new
    @input = 0
  end

  def test_transaction
    vm = VendingMachine.new([@product], 0, @sales_maneger)

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

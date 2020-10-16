class Product
  @@tax = 0.1

  attr_reader :name, :price

  def initialize(args={})
    @name = args[:name] || default_name
    @price = args[:price] || default_price
  end

  def default_name
    raise NotImplementedError
  end

  def default_price
    raise NotImplementedError
  end

  def price
    @price + (@price * @@tax).floor
  end
end

class Beverage < Product
  def default_name
    'コーラ'
  end

  def default_price
    120
  end
end

class Tabaco < Product
  @@tax = 0.6

  def default_name
    'テックタバコ'
  end

  def default_price
    300
  end
end

class Ticket < Product
  def default_name
    '渋谷'
  end

  def default_price
    150
  end
end

class VendingMachine
  def initialize(products, input, sales_maneger)
    @products = products
    @input = input
    @sales_maneger = sales_maneger
  end

  def transaction
    display_anounce
    product = take_order
    sales_maneger.update(product)
  end

  private

  attr_reader :products

  def display_anounce
    puts '購入したい商品を以下から選んで、金額を入力してください'
    products.each_with_index do |product, i|
      puts "[#{i}] 商品名：#{product.name} 税込み価格：#{product.price}円"
    end
  end

  def take_order
    product = @products[@input]
    puts "#{product.name}が選択されました"
    product
  end

  def calc_change(payment, price)
    payment - price
  end
end

class VendingMachine < VendingMachineBase; end

class TicketVendingMachine < VendingMachineBase;
  private

  def display_anounce
    puts "区間を選んで表示された金額を入力してください"
    @products.each_with_index do |product, i|
      puts "[#{i}] 行き先：#{product.name} 金額：#{product.price}円"
    end
  end
end

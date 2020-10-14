class SalesManeger
  attr_reader :net_sales

  def initialize
    @net_sales = 0
  end

  def update(product)
    @net_sales += product.price
  end
end

class Beverage
  @@tax = 0.1

  attr_reader :name, :price

  def initialize(args)
    @name = args.fetch(:name, 'サイダー')
    @price = args.fetch(:price, 120)
  end

  def price
    @price + (@price * @@tax).floor
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

  attr_reader :products, :sales_maneger

  def display_anounce
    puts '購入したい商品を以下から選んで、金額を入力してください'
    @products.each_with_index do |product, i|
      puts "[#{i}] 商品名：#{product.name} 税込み価格：#{product.price}円"
    end
  end

  def take_order
    # ドリンクはランダムに選ばれる
    product = @products[@input]
    puts "#{product.name}が選択されました"
    product
  end

  def calc_change(payment, price)
    payment - price
  end
end

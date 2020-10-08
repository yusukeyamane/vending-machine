class Products
  attr_reader :parts

  def initialize(parts)
    @parts = parts
  end
end

class Product
  attr_reader :name, :price, :tax

  def initialize(args)
    @name = args[:name]
    @price = args[:price]
    @tax = args[:tax]
  end

  def price
    @price + (@price * @tax).floor
  end
end

module ElectronicMoney
  #電子マネーをチャージする
  def charge
    puts '電子マネーにチャージする金額を入力してください。'
    amount = gets.to_i
    puts "#{amount}円がチャージされました。"
  end
end

module ProductsFactory
  def self.build(config)
    config.map { |product_config|
      Product.new(
        {
          name: product_config[0],
          price: product_config[1],
          tax: product_config.fetch(2, 0.1)
        }
      )
    }
  end
end

class VendingMachine
  def initialize(products)
    @products = products
  end

  def transaction
    display_anounce
    product = take_order
    serve_item(product)
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
    selected = products[gets.to_i]
    puts "#{selected.name}が選択されました。必要金額は#{selected.price}円です。"
    selected
  end

  def serve_item(product)
    # 適正金額が受け取れるまで繰り返す。
    while true do
      payment = gets.to_i
      charge = calc_change(payment, product.price)
      if charge >= 0
        break
      else
        puts "入力金額が不足しています。金額を再入力してください。"
      end
    end

    puts "お釣りは#{charge}円です。ご利用ありがとうございました。"
  end

  def calc_change(payment, price)
    payment - price
  end
end

class TicketVendingMachine < VendingMachine
  include ElectronicMoney

  def transaction
    puts '電子マネーのチャージなら1を、切符の購入なら2を押してください'
    input = gets.to_i

    if input == 1
      super
    elsif input == 2
      charge
    else
      puts '電子マネーのチャージなら1を、切符の購入なら2を押してください'
    end
  end

  private

  attr_reader :products

  def display_anounce
    puts "区間を選んで表示された金額を入力してください"
    products.each_with_index do |product, i|
      puts "[#{i}] 行き先：#{product.name} 金額：#{product.price}円"
    end
  end
end

beverage_config = [
  ['コーラ', 120],
  ['お茶', 100],
  ['お水', 80]
]

beverages = ProductsFactory.build(beverage_config)

vm = VendingMachine.new(beverages)
vm.transaction

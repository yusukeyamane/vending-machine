# 4章問題用コード
class Beverage
  attr_reader :name, :price, :tax

  def initialize(args)
    @tax = args.fetch(:tax, 0.1)
    @name = args.fetch(:name, 'サイダー')
    @price = args.fetch(:price, 120)
  end

  def price
    @price + (@price * tax).floor
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

  def display_anounce
    puts '購入したい商品を以下から選んで、金額を入力してください'
    products.each_with_index do |product, i|
      puts "[#{i}] 商品名：#{product.name} 税込み価格：#{product.price}円"
    end
  end

  def take_order
    products[gets.to_i]
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

  attr_reader :products
end

beverages = [
  { name: 'コーラ', price: 120 },
  { name: 'お茶', price: 100 },
  { name: 'お水', price: 80 }
]

@beverages = beverages.map{ |b| Beverage.new(name: b[:name], price: b[:price]) }
vm = VendingMachine.new(@beverages)
vm.transaction

# 4章解答用コード
class Beverage
  attr_reader :name, :price, :tax

  def initialize(args)
    @tax = args.fetch(:tax, 0.1)
    @name = args.fetch(:name, 'サイダー')
    @price = args.fetch(:price, 120)
  end

  def price
    @price + (@price * tax).floor
  end
end

class VendingMachine
  attr_reader :products

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
    products[gets.to_i]
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

beverages = [
  { name: 'コーラ', price: 120 },
  { name: 'お茶', price: 100 },
  { name: 'お水', price: 80 }
]

@beverages = beverages.map{ |b| Beverage.new(name: b[:name], price: b[:price]) }
vm = VendingMachine.new(@beverages)
vm.transaction

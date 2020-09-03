class Beverage
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end

class VendingMachine
  def initialize(tax)
    @tax = tax
  end

  def serve_item
    display_anounce
    product = take_order

    # 適正金額が受け取れるまで繰り返す。
    while true do
      payment = take_money
      charge = calc_change(payment, product.price)
      if charge >= 0
        break
      else
        puts "入力金額が不足しています。金額を再入力してください。"
      end
    end

    puts "お釣りは#{charge}円です。ご利用ありがとうございました。"
  end

  private

  def products
    beverages = [
      { name: 'コーラ', price: calc_price(120) },
      { name: 'お茶', price: calc_price(100) },
      { name: 'お水', price: calc_price(80) }
    ]
    beverages.map{ |b| Beverage.new(b[:name], b[:price]) }
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

  def take_money
    gets.to_i
  end

  def calc_change(payment, price)
    payment - price
  end

  def calc_price(price)
    price + (price * @tax).floor
  end
end

vm = VendingMachine.new(0.1)
vm.serve_item

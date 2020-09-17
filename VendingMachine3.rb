## 第3章 問題文
class Beverage
  attr_reader :name, :price, :tax

  def initialize(name, price, tax)
    @name = name
    @tax = tax
    @price = price
  end


  def price
    @price + (@price * @tax).floor
  end
end

class VendingMachine
  def initialize(tax)
    @tax = tax

    beverages = [
      { name: 'コーラ', price: 120 },
      { name: 'お茶', price: 100 },
      { name: 'お水', price: 80 }
    ]
    @products = beverages.map{ |b| Beverage.new(b[:name], b[:price], @tax) }
  end

  def transaction
    display_anounce
    product = take_order
    serve_item(product)
  end

  private

  def display_anounce
    puts '購入したい商品を以下から選んで、金額を入力してください'
    @products.each_with_index do |product, i|
      puts "[#{i}] 商品名：#{product.name} 税込み価格：#{product.price}円"
    end
  end

  def take_order
    @products[gets.to_i]
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

vm = VendingMachine.new(0.1)
vm.transaction

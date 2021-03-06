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
    @products.each_with_index do |product, i|
      puts "[#{i}] 商品名：#{product.name} 税込み価格：#{product.price}円"
    end
  end

  def take_order
    product = @products[gets.to_i]
    puts "#{product}が選択されました"
    product
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

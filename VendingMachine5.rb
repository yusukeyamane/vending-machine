# 5章問題用コード
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

class Tabaco
  @@tax = 0.6
  attr_reader :brand, :cost

  def initialize(args)
    @brand = args.fetch(:brand, 'テックタバコ')
    @cost = args.fetch(:cost, 300)
  end

  def cost
    @cost + (@cost * @@tax).floor
  end
end

class VendingMachine
  attr_reader :products

  def initialize(products)
    @products = products
  end

  def serve_item
    display_anounce
    product = take_order
    p "#{product.name}が選択されました"

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

  def take_money
    gets.to_i
  end

  def calc_change(payment, price)
    payment - price
  end
end

tabacos = [
  { brand: '第一タバコ', cost: 120 },
  { brand: 'サムライ', cost: 100 },
  { brand: 'キャッツアイ', cost: 80 }
]

@tabacos = tabacos.map{ |b| Tabaco.new(name: b[:brand], price: b[:cost]) }
vm = VendingMachine.new(@beverages)
vm.serve_item

# 5章解答用コード
# class Beverage
#   @@tax = 0.1
#   attr_reader :name, :price

#   def initialize(args)
#     @name = args.fetch(:name, 'サイダー')
#     @price = args.fetch(:price, 120)
#   end

#   def price
#     @price + (@price * @@tax).floor
#   end
# end

# class Tabaco
#   @@tax = 0.6
#   attr_reader :name, :price, :tax

#   def initialize(args)
#     @name = args.fetch(:name, 'テックタバコ')
#     @price = args.fetch(:price, 300)
#   end

#   def price
#     @price + (@price * @@tax).floor
#   end
# end

# class VendingMachine
#   attr_reader :products

#   def initialize(products)
#     @products = products
#   end

#   def transaction
#     display_anounce
#     product = take_order
#     serve_item(product)
#   end

#   private

#   attr_reader :products

#   def display_anounce
#     puts '購入したい商品を以下から選んで、金額を入力してください'
#     products.each_with_index do |product, i|
#       puts "[#{i}] 商品名：#{product.name} 税込み価格：#{product.price}円"
#     end
#   end

#   def take_order
#     products[gets.to_i]
#   end

#   def serve_item(product)
#     # 適正金額が受け取れるまで繰り返す。
#     while true do
#       payment = gets.to_i
#       charge = calc_change(payment, product.price)
#       if charge >= 0
#         break
#       else
#         puts "入力金額が不足しています。金額を再入力してください。"
#       end
#     end

#     puts "お釣りは#{charge}円です。ご利用ありがとうございました。"
#   end

#   def calc_change(payment, price)
#     payment - price
#   end
# end

# tabacos = [
#   { name: '第一タバコ', price: 120 },
#   { name: 'サムライ', price: 100 },
#   { name: 'キャッツアイ', price: 80 }
# ]

# @tabacos = tabacos.map{ |b| Tabaco.new(name: b[:name], price: b[:price]) }
# vm = VendingMachine.new(@tabacos)
# vm.transaction

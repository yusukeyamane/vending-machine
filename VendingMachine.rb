# class Beverage
#   def initialize(name)
#     @name =
#     @tax =
#   end
# end

# class Tabacos
#   @tax = 0.1
# end

# class VendingMachine
#   def initialize
#     @tax = 0.1
#     @products = [
#       { name: 'コーラ', price: 120 },
#       { name: 'お茶', price: 100 },
#       { name: 'お水', price: 80 }
#     ]
#   end

#   def serve_item
#     display_anounce
#     product = take_order
#     price = calc_price(product[:price])

#     # 適正金額が受け取れるまで繰り返す。
#     while true do
#       payment = take_money
#       charge = calc_change(payment, price)
#       if charge >= 0
#         break
#       else
#         puts "入力金額が不足しています。金額を再入力してください。"
#       end
#     end

#     puts "お釣りは#{charge}円です。ご利用ありがとうございました。"
#   end

#   private

#   def display_anounce
#     puts '購入したい商品を以下から選んで、金額を入力してください'
#     @products.each_with_index do |product, i|
#       puts "[#{i}] 商品名：#{product[:name]} 税込み価格：#{calc_price(product[:price])}"
#     end
#   end

#   def take_order
#     ordered = @products[gets.to_i]
#     p "#{ordered[:name]}が選択されました"
#     ordered
#   end

#   def take_money
#     gets.to_i
#   end

#   def calc_price(price)
#     price += price * @tax
#     price.floor
#   end

#   def calc_change(payment, price)
#     payment - price
#   end
# end

# vm = VendingMachine.new
# vm.serve_item


# NEW Code
class Beverage
  @@tax = 0.1

  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = (price += price * @@tax).floor
  end
end

class VendingMachine
  def initialize(products)
    @products = products
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

  def display_anounce
    puts '購入したい商品を以下から選んで、金額を入力してください'
    @products.each_with_index do |product, i|
      puts "[#{i}] 商品名：#{product.name} 税込み価格：#{product.price}円"
    end
  end

  def take_order
    ordered = @products[gets.to_i]
    p "#{ordered.name}が選択されました"
    ordered
  end

  def take_money
    gets.to_i
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

@beverages = beverages.map{ |b| Beverage.new(b[:name], b[:price]) }
vm = VendingMachine.new(@beverages)
vm.serve_item

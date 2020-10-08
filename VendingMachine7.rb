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

module ElectronicMoney
  #電子マネーをチャージする
  def charge
    puts '電子マネーにチャージする金額を入力してください。'
    amount = gets.to_i
    puts "#{amount}円がチャージされました。"
  end
end

class VendingMachineBase
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

class TicketVendingMachine < VendingMachineBase
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

class VendingMachine < VendingMachineBase; end

tickets = [
  { name: '渋谷', price: 200 },
  { name: '品川', price: 300 },
  { name: '静岡', price: 1000 }
]

@tickets = tickets.map{ |t| Ticket.new({name: t[:name], price: t[:price]}) }
tvm = TicketVendingMachine.new(@tickets)
tvm.transaction

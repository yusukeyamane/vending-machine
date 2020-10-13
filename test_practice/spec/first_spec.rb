require 'spec_helper'
require '../VendingMachine'

RSpec.describe 'VendingMachine.rb', type: :request do
  describe 'Product' do
    describe '.price' do
      it 'priceが正しい値段を返すこと' do
        beverage = Beverage.new({ name: 'コーラ', price: 120 })
        expect(beverage.price).to equal((120 * 1.1).floor)
      end
    end
  end

  describe 'VendingMachine' do
    describe '.take_order' do
      beverages = [
        { name: 'コーラ', price: 120 },
        { name: 'お茶', price: 100 },
        { name: 'お水', price: 80 }
      ]
      products = beverages.map { |b| Beverage.new({ name: b[:name], price: b[:price] }) }

      it 'Beverageのインスタンスが返却されること' do
        vm = VendingMachine.new(products)
        expect(products).to include vm.take_order
      end
    end
  end
end

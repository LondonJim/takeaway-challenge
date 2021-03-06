require 'order'

describe Order do

  menu = [{ food: "food1", price: 1 }]
  menu_two = [{ food: "food1", price: 1 },
              { food: "food1", price: 1 },
              { food: "food2", price: 2 }]

  let(:order) { Order.new(menu) }

  describe '#select_items' do
    it 'places hashes into @selected array' do
      order.add_items(1, 2)
      expect(order.instance_variable_get(:@selected)).to eq [{ :food => "food1", :price => 1 },
                                                             { :food => "food1", :price => 1 }]
    end

    it 'raises_error if item_number is not recognised' do
      expect { order.add_items(2) }.to raise_error 'Item number not recognised'
      expect { order.add_items(-2) }.to raise_error 'Item number not recognised'
    end

  end

  describe '@total_cost' do
    it 'returns total added values of :price in @selected' do
      order.instance_variable_set(:@selected, menu_two)
      expect(order.send(:total_cost)).to eq 4
    end
  end

  describe '#complete_order' do

    it 'returns order completed' do
      allow(order).to receive(:send_to_messenger)
      order.instance_variable_set(:@selected, menu_two)

      expect(order.complete_order).to eq 'Order Completed, TXT confirmation sent'
    end

    it 'fails if no elements in @selected' do
      expect { order.complete_order }.to raise_error 'No items selected'
    end

    describe '#reset_order' do
      it 'resets @selected @total' do
        order.instance_variable_set(:@selected, menu_two)
        order.instance_variable_set(:@total, 10)
        order.send(:reset_order)
        expect(order.instance_variable_get(:@selected)).to eq []
        expect(order.instance_variable_get(:@total)).to eq 0
      end
    end
  end
end

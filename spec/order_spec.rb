require 'order'

describe Order do

  menu = [{ food: "food1", price: 1 }]
  menu_two = [{ food: "food1", price: 1 },
              { food: "food1", price: 1 },
              { food: "food2", price: 2 }]
  let(:order) { Order.new(menu) }

  it 'sets @menu on initialize' do
    expect(order.menu).to eq menu
  end

  describe '#list_menu' do
    context 'returns #menu' do
      it { expect(order.list_menu).to eq order.menu }
    end
  end

  describe '#menu' do
    context 'stores menu' do
      it { expect(order.menu).to eq menu }
    end
  end

  describe '#select_items' do
    it 'places hashes into @selected array' do
      order.add_items(1, 2)
      expect(order.selected).to eq [{ :food => "food1", :price => 1 },
                                    { :food => "food1", :price => 1 }]
    end
  end

  describe '#list_order' do
    it 'creates new array with #selected duplicate count added' do
      order.instance_variable_set(:@selected, menu_two)
      order.list_order
      expect(order.ordered_list).to eq [[{ :food => "food1", :price => 1 }, 2], [{ :food => "food2", :price => 2 }, 1]]
    end
  end

end

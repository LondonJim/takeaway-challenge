require_relative 'menu'
require_relative 'messenger'
require_relative 'display'

class Order

  def initialize(menu = Menu.new.current_menu,
                 messenger = Messenger.new,
                 display = Display.new)
    @display = display
    @menu = menu
    @messenger = messenger
    @selected = []
  end

  def display_menu
    @display.menu(@menu)
  end

  def display_order
    @display.order(@selected)
  end

  def display_added(amount)
    @display.single_item(@selected, amount)
  end

  def add_items(item_number, amount = 1)
    fail 'Item number not recognised' if recognise_item?(item_number)
    amount.times { @selected << @menu[item_number - 1] }
    display_added(amount)
  end

  def complete_order
    fail 'No items selected' if @selected == []
    total_cost
    send_to_messenger
    reset_order
    "Order Completed, TXT confirmation sent"
  end

  def reset_order
    @selected = []
    @total = 0
    "Order reset"
  end

  private

  def recognise_item?(item_number)
    item_number > @menu.count || item_number < 1
  end

  def send_to_messenger
    @messenger.completed_order(@total)
  end

  def total_cost
    @total = 0
    @selected.each { |item| @total += item[:price] }
    @total
  end

end

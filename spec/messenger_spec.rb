require 'messenger'

describe Messenger do

  let(:messenger) { Messenger.new }

  describe '#complete_order' do

    before do
      allow(messenger).to receive(:delivery_time) { "09:45" }
      allow(messenger).to receive(:send_sms)
    end

    it 'sends a payment confirmation text message' do
      expect(messenger).to receive(:send_sms).with("Thank you! Your order totalling £14 was placed and will be delivered before 09:45")
      messenger.completed_order(14)
    end
  end

  describe '#midnight_compensate' do

    it 'compensates for midnight delivery time' do
      messenger.send(:delivery_time, Time.local(2018, 1, 1, 23, 30, 0))
      expect(messenger.send(:midnight_compensate)).to eq 00
    end
  end
end

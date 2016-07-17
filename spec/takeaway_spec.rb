require 'takeaway'

describe Takeaway do
  let(:menu) { double(:menu, print_menu: printed_menu, dishes: "sashimi") }
  subject(:takeaway) { described_class.new(menu, basket) }
  let(:basket) { double(:basket) }
  let(:sms) { double(:double) }
  let(:printed_menu) { "sashimi: £4" }

  describe '#read_menu' do
    it 'should print a list of dishes with prices' do
      expect(takeaway.read_menu).to eq(printed_menu)
    end
  end

  describe '#order' do
    it 'should raise an error if the dish is not on menu' do
      expect{takeaway.order("burger", 4)}.to raise_error "Sorry, this is not on the menu"
    end
    it 'should confirm what has been added to basket' do
      expect(basket).to receive(:add)
      expect(takeaway.order("sashimi", 2)).to eq("2x sashimi(s) added to your basket.")
    end
  end

  describe '#confirm_order' do
    it 'should send an SMS to confirm the order' do
      expect(basket).to receive(:add)
      expect(sms).to receive(:deliver)
      takeaway.order("sashimi", 3)
      takeaway.confirm_order
    end
  end

end


# # not sure whether the below test is required as we have the same
# # thing in menu spec.
#   describe '#read_menu' do
#     it 'prints a list of dishes with prices' do
#       expect(takeaway.read_menu).to be_a(Hash)
#     end
#   end
#   describe '#add' do
#     it 'passed a dish and quantity to the menu class' do
#       takeaway.add("sashimi", 2)
#       expect(takeaway.basket_summary).to eq("2x sashimi")
#     end
#     it 'should raise an error if the dish is not on menu' do
#       expect{takeaway.add("burger", 4)}.to raise_error "Sorry, this is not on the menu"
#     end
#
#     it 'should confirm that the order has been added to basket' do
#       expect(takeaway.add("sashimi", 3)).to eq("3x sashimi(s) added to your basket.")
#     end
#   end
#
#   # describe '#basket_summary' do
#   #   it "requests a basket summary from the basket class" do
#   #     expect(takeaway.)
#   #   end
#   # end
#
# end

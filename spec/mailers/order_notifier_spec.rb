require "spec_helper"

describe OrderNotifier do
  let(:order) { create(:order) }
  describe "received" do
    let(:mail) { OrderNotifier.received(order) }

    it "renders the headers" do
      mail.subject.should eq("Pragmatic Store Order Confirmation")
      mail.to.should eq([order.email])
      mail.from.should eq(["depot@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("recent order")
    end
  end

  describe "shipped" do
    let(:mail) { OrderNotifier.shipped(order) }

    it "renders the headers" do
      mail.subject.should eq("Pragmatic Store Order Shipped")
      mail.to.should eq([order.email])
      mail.from.should eq(["depot@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Order Shipped")
    end
  end

end

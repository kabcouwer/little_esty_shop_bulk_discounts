require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
  end
  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  describe "instance methods" do
    describe "#discount_applied?" do
      it "finds discount_applied? for example 1" do
        @merchant1 = Merchant.create!(name: 'Hair Care')
        @bd_1 = @merchant1.bulk_discounts.create!(percentage: 0.20, quantity_threshold: 10)
        @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
        @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
        @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
        @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
        @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 5, unit_price: 10, status: 2)
        @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 5, unit_price: 10, status: 1)

        expect(@ii_1.discount_applied?(@merchant1)).to eq(false)
        expect(@ii_11.discount_applied?(@merchant1)).to eq(false)
      end

      it "finds discount_applied? for example 2" do
        @merchant1 = Merchant.create!(name: 'Hair Care')
        @bd_1 = @merchant1.bulk_discounts.create!(percentage: 0.20, quantity_threshold: 10)
        @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
        @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
        @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
        @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
        @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 10, unit_price: 10, status: 2)
        @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 5, unit_price: 10, status: 1)

        expect(@ii_1.discount_applied?(@merchant1)).to eq(true)
        expect(@ii_11.discount_applied?(@merchant1)).to eq(false)
      end

      it "finds discount_applied? for example 3" do
        @merchant1 = Merchant.create!(name: 'Hair Care')
        @bd_1 = @merchant1.bulk_discounts.create!(percentage: 0.20, quantity_threshold: 10)
        @bd_2 = @merchant1.bulk_discounts.create!(percentage: 0.30, quantity_threshold: 15)
        @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
        @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
        @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
        @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
        @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 12, unit_price: 10, status: 2)
        @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 15, unit_price: 10, status: 1)

        expect(@ii_1.discount_applied?(@merchant1)).to eq(true)
        expect(@ii_11.discount_applied?(@merchant1)).to eq(true)
        expect(@ii_1.bulk_discount(@merchant1)).to eq(@bd_1)
        expect(@ii_11.bulk_discount(@merchant1)).to eq(@bd_2)
      end

      it "finds discount_applied? for example 4" do
        @merchant1 = Merchant.create!(name: 'Hair Care')
        @bd_1 = @merchant1.bulk_discounts.create!(percentage: 0.20, quantity_threshold: 10)
        @bd_2 = @merchant1.bulk_discounts.create!(percentage: 0.15, quantity_threshold: 15)
        @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
        @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
        @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
        @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
        @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 12, unit_price: 10, status: 2)
        @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 15, unit_price: 10, status: 1)

        expect(@ii_1.discount_applied?(@merchant1)).to eq(true)
        expect(@ii_11.discount_applied?(@merchant1)).to eq(true)
        expect(@ii_1.bulk_discount(@merchant1)).to eq(@bd_1)
        expect(@ii_11.bulk_discount(@merchant1)).to eq(@bd_1)
      end

      it "finds discount_applied? for example 5" do
        @merchant1 = Merchant.create!(name: 'Hair Care')
        @merchant2 = Merchant.create!(name: 'Sports Ball Stuff')
        @bd_1 = @merchant1.bulk_discounts.create!(percentage: 0.20, quantity_threshold: 10)
        @bd_2 = @merchant1.bulk_discounts.create!(percentage: 0.30, quantity_threshold: 15)
        @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
        @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
        @item_10 = @merchant2.items.create!(name: 'Ball', description: 'It bounces', unit_price: 8)
        @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
        @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
        @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 12, unit_price: 10, status: 2)
        @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 15, unit_price: 10, status: 1)
        @ii_4 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_10.id, quantity: 15, unit_price: 10, status: 1)

        expect(@ii_1.discount_applied?(@merchant1)).to eq(true)
        expect(@ii_11.discount_applied?(@merchant1)).to eq(true)
        expect(@ii_4.discount_applied?(@merchant2)).to eq(false)
        expect(@ii_1.bulk_discount(@merchant1)).to eq(@bd_1)
        expect(@ii_11.bulk_discount(@merchant1)).to eq(@bd_2)
      end
    end
  end
end

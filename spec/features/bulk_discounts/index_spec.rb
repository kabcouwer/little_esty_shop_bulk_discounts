require 'rails_helper'

RSpec.describe 'discount index page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @bd_1 = @merchant1.bulk_discounts.create!(percentage: 20.0, quantity_threshold: 10)
    @bd_2 = @merchant1.bulk_discounts.create!(percentage: 10.0, quantity_threshold: 5)
    @bd_3 = @merchant1.bulk_discounts.create!(percentage: 15.0, quantity_threshold: 10)


    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    @customer_2 = Customer.create!(first_name: 'Cecilia', last_name: 'Jones')
    @customer_3 = Customer.create!(first_name: 'Mariah', last_name: 'Carrey')
    @customer_4 = Customer.create!(first_name: 'Leigh Ann', last_name: 'Bron')
    @customer_5 = Customer.create!(first_name: 'Sylvester', last_name: 'Nader')
    @customer_6 = Customer.create!(first_name: 'Herber', last_name: 'Coon')

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)
    @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2)
    @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
    @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 1)

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
    @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
    @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
    @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 8, status: 0)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)
    @ii_4 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)

    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
    @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_3.id)
    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_4.id)
    @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_5.id)
    @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_6.id)
    @transaction6 = Transaction.create!(credit_card_number: 879799, result: 1, invoice_id: @invoice_7.id)
    @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_2.id)

    visit merchant_bulk_discounts_path(@merchant1)
  end

  it 'displays all bulk discounts and attributes for a merchant' do
    within "#discount-#{@bd_1.id}" do
      expect(page).to have_content(@bd_1.percentage)
      expect(page).to have_content(@bd_1.quantity_threshold)
    end

    within "#discount-#{@bd_2.id}" do
      expect(page).to have_content(@bd_2.percentage)
      expect(page).to have_content(@bd_2.quantity_threshold)
    end

    within "#discount-#{@bd_3.id}" do
      expect(page).to have_content(@bd_3.percentage)
      expect(page).to have_content(@bd_3.quantity_threshold)
    end
  end

  it 'has a link for each discount to its show page' do
    expect(page).to have_link('Discount 1')
    expect(page).to have_link('Discount 2')
    expect(page).to have_link('Discount 3')

    click_link('Discount 1')

    expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts/#{@bd_1.id}")
    expect(page).to have_content(@bd_1.percentage)
    expect(page).to have_content(@bd_1.quantity_threshold)
    expect(page).to have_no_content(@bd_2.percentage)
    expect(page).to have_no_content(@bd_2.quantity_threshold)
  end

  it "has a section with a header of 'Upcoming Holidays' which has the name and date of the next 3 upcoming US holidays" do
    expect(page).to have_content('Upcoming Holidays')
    expect(page).to have_content('Labour Day')
    expect(page).to have_content('2021-09-06')
    expect(page).to have_content('Columbus Day')
    expect(page).to have_content('2021-10-11')
    expect(page).to have_content('Veterans Day')
    expect(page).to have_content('2021-11-11')
  end

  it 'has a link to create a new discount' do
    click_link('Create New Bulk Discount')

    expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts/new")
  end

  it 'can create a new bulk discount' do
    click_link('Create New Bulk Discount')

    fill_in('bulk_discount_percentage', with: 50)
    fill_in('bulk_discount_quantity_threshold', with: 50)

    click_button('Submit')

    expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts")

    new_bd = BulkDiscount.last

    within "#discount-#{new_bd.id}" do
      expect(page).to have_no_content(@bd_3.percentage)
      expect(page).to have_no_content(@bd_3.quantity_threshold)
      expect(page).to have_content(new_bd.percentage)
      expect(page).to have_content(new_bd.quantity_threshold)
    end
  end
end

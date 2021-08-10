class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, :'in progress', :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def discount(discount)
    invoice_items.sum("unit_price * quantity") * discount.percentage
  end

  # def discount(discount)
  #   wip = invoice_items
  #   .joins(item: [merchant: :bulk_discounts])
  #   .select('invoice_items.*, sum(discount.percentage * unit_price * quantity) as discount')
  #   .group(:id)
  #   binding.pry
  # end

  def discounted_revenue(discount)
    total_revenue - discount(discount)
  end
end

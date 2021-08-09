class BulkDiscount < ApplicationRecord
  validates_presence_of :percentage
  validates_presence_of :quantity_threshold
  belongs_to :merchant
end

BulkDiscount.destroy_all

@bd1 = BulkDiscount.create!(percentage: 0.05, quantity_threshold: 2, merchant_id: 1)
@bd2 = BulkDiscount.create!(percentage: 0.15, quantity_threshold: 10, merchant_id: 1)
@bd3 = BulkDiscount.create!(percentage: 0.20, quantity_threshold: 20, merchant_id: 1)

@bd4 = BulkDiscount.create!(percentage: 0.05, quantity_threshold: 3, merchant_id: 2)
@bd5 = BulkDiscount.create!(percentage: 0.10, quantity_threshold: 5, merchant_id: 2)
@bd6 = BulkDiscount.create!(percentage: 0.15, quantity_threshold: 10, merchant_id: 2)

@bd7 = BulkDiscount.create!(percentage: 0.10, quantity_threshold: 5, merchant_id: 3)
@bd8 = BulkDiscount.create!(percentage: 0.15, quantity_threshold: 10, merchant_id: 3)
@bd9 = BulkDiscount.create!(percentage: 0.20, quantity_threshold: 20, merchant_id: 3)

@bd10 = BulkDiscount.create!(percentage: 0.10, quantity_threshold: 5, merchant_id: 4)

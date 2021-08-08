class DiscountsController < ApplicationController
  before_action :get_merchant, only: [:index, :show]
  def index
    @discounts = @merchant.bulk_discounts
  end

  def show
    @discount = BulkDiscount.find(params[:id])
  end

  private
  def get_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end

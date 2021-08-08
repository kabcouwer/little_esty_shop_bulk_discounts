class DiscountsController < ApplicationController
  before_action :get_merchant, only: [:index, :show]
  before_action :swagger_data, only: [:index]
  def index
    @discounts = @merchant.bulk_discounts
  end

  def show
    @discount = BulkDiscount.find(params[:id])
  end

  private
  def swagger_data
    @holidays = SwaggerData.holidays
  end
  def get_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end

class BulkDiscountsController < ApplicationController
  before_action :get_merchant, only: [:index, :show, :new, :create]
  before_action :swagger_data, only: [:index]
  
  def index
    @discounts = @merchant.bulk_discounts
  end

  def show
    @discount = BulkDiscount.find(params[:id])
  end

  def new
    @discount = BulkDiscount.new
  end

  def create
    bd = @merchant.bulk_discounts.create(bulk_discount_params)
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  private
  def bulk_discount_params
    params.require(:bulk_discount).permit(:percentage, :quantity_threshold)
  end

  def swagger_data
    @holidays = SwaggerData.holidays
  end

  def get_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end

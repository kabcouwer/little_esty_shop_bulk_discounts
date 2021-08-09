class BulkDiscountsController < ApplicationController
  before_action :get_merchant
  before_action :get_discount, only: [:show, :edit, :update, :destroy]
  before_action :swagger_data, only: [:index]

  def index
    @discounts = @merchant.bulk_discounts
  end

  def show
  end

  def new
    @discount = BulkDiscount.new
  end

  def create
    bd = @merchant.bulk_discounts.create(bulk_discount_params)
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  def edit
  end

  def update
    @discount.update(bulk_discount_params)
    redirect_to merchant_bulk_discount_path(@merchant, @discount)
  end

  def destroy
    @discount.destroy
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  private
  def bulk_discount_params
    params.require(:bulk_discount).permit(:percentage, :quantity_threshold)
  end

  def get_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def get_discount
    @discount = BulkDiscount.find(params[:id])
  end

  def swagger_data
    @holidays = SwaggerData.holidays
  end
end

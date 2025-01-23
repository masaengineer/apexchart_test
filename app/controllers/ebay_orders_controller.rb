class EbayOrdersController < ApplicationController
  def index
    @ebay_orders = EbayOrder.order(created_at: :desc).page(params[:page]).per(20)
  end

  def show
    @ebay_order = EbayOrder.find_by!(order_id: params[:id])
  end
end

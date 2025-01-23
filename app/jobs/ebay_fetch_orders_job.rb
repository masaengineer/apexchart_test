class EbayFetchOrdersJob < ApplicationJob
  queue_as :default

  def perform
    auth_client = Ebay::AuthClient.new
    access_token = auth_client.fetch_access_token

    fulfillment_client = Ebay::FulfillmentClient.new(access_token)
    response_data = fulfillment_client.get_orders(limit: 50, offset: 0)

    orders = response_data["orders"] || []
    orders.each do |order_data|
      order_id = order_data["orderId"]

      # 既存の注文を更新または新規作成
      EbayOrder.find_or_initialize_by(order_id: order_id).tap do |ebay_order|
        ebay_order.order_data = order_data
        ebay_order.save!
      end
    end
  rescue StandardError => e
    Rails.logger.error "[EbayFetchOrdersJob] Error: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    # 必要に応じて通知処理を追加
  end
end

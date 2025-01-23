module Ebay
  class FulfillmentClient
    BASE_URL = "https://api.ebay.com/sell/fulfillment/v1"

    def initialize(access_token)
      @access_token = access_token
      @connection = Faraday.new(url: BASE_URL) do |faraday|
        faraday.request :url_encoded
        faraday.headers['Authorization'] = "Bearer #{@access_token}"
        faraday.headers['Content-Type'] = 'application/json'
        faraday.adapter Faraday.default_adapter
      end
    end

    def get_orders(limit: 50, offset: 0)
      response = @connection.get('order', { limit: limit, offset: offset })

      if response.status == 200
        JSON.parse(response.body)
      else
        Rails.logger.error "Failed to fetch orders: #{response.body}"
        raise StandardError, "Failed to fetch orders: #{response.status}"
      end
    end

    def get_order(order_id)
      response = @connection.get("order/#{order_id}")

      if response.status == 200
        JSON.parse(response.body)
      else
        Rails.logger.error "Failed to fetch order #{order_id}: #{response.body}"
        raise StandardError, "Failed to fetch order: #{response.status}"
      end
    end
  end
end

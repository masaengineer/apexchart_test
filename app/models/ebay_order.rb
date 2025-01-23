class EbayOrder < ApplicationRecord
  # バリデーション
  validates :order_id, presence: true, uniqueness: true
  validates :order_data, presence: true

  # order_dataから必要な情報を取得するメソッド
  def buyer_username
    order_data&.dig("buyer", "username")
  end

  def total_price
    order_data&.dig("pricingSummary", "total", "value")
  end

  def order_status
    order_data&.dig("orderFulfillmentStatus")
  end

  def created_date
    order_data&.dig("creationDate")
  end
end

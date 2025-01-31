class EbayOrdersController < ApplicationController
  def index
    begin
      auth_client = Ebay::AuthClient.new
      refresh_token = Rails.application.credentials.ebay[:refresh_token]

      # より詳細なデバッグ情報
      Rails.logger.debug "Full Credentials: #{Rails.application.credentials.config.inspect}"
      Rails.logger.debug "Ebay Credentials: #{Rails.application.credentials.ebay.inspect}"
      Rails.logger.debug "Refresh Token Direct: #{Rails.application.credentials.ebay[:refresh_token].inspect}"

      if refresh_token.present?
        token_response = auth_client.refresh_access_token(refresh_token)
        Rails.logger.debug "Token Response: #{token_response.inspect}"

        if token_response["access_token"].present?
          fulfillment_client = Ebay::FulfillmentClient.new(token_response["access_token"])
          @orders = fulfillment_client.get_orders["orders"] || []
        else
          raise "アクセストークンの取得に失敗しました: #{token_response}"
        end
      else
        raise "リフレッシュトークンが設定されていません"
      end
    rescue StandardError => e
      Rails.logger.error "Error in EbayOrdersController#index: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      flash.now[:error] = "eBayの注文情報の取得に失敗しました: #{e.message}"
      @orders = []
    end
  end
end

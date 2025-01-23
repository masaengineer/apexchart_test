require 'faraday'
require 'json'

module Ebay
  class AuthClient
    TOKEN_ENDPOINT = "https://api.ebay.com/identity/v1/oauth2/token"

    def initialize
      @client_id = Rails.application.credentials.dig(:ebay, :client_id)
      @client_secret = Rails.application.credentials.dig(:ebay, :client_secret)
      @refresh_token = Rails.application.credentials.dig(:ebay, :refresh_token)
    end

    def fetch_access_token
      response = Faraday.post(TOKEN_ENDPOINT) do |req|
        req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
        req.basic_auth(@client_id, @client_secret)
        req.body = {
          grant_type: 'refresh_token',
          refresh_token: @refresh_token,
          scope: 'https://api.ebay.com/oauth/api_scope/sell.fulfillment.readonly'
        }.to_query
      end

      if response.status == 200
        body = JSON.parse(response.body)
        body["access_token"]
      else
        Rails.logger.error "Failed to fetch access token: #{response.body}"
        raise StandardError, "Failed to fetch access token: #{response.status}"
      end
    end
  end
end

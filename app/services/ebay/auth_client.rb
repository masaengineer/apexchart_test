require 'faraday'
require 'json'
require 'base64'
require 'active_support/core_ext/object/to_query'

module Ebay
  class AuthClient
    AUTH_URL = 'https://auth.ebay.com/oauth2/authorize'.freeze
    TOKEN_URL = 'https://api.ebay.com/identity/v1/oauth2/token'.freeze

    def initialize
      @client_id = Rails.application.credentials.ebay[:client_id]
      @client_secret = Rails.application.credentials.ebay[:client_secret]
      @ru_name = Rails.application.credentials.ebay[:ru_name]

      @connection = Faraday.new(url: TOKEN_URL) do |f|
        f.request :url_encoded
        f.response :json
        f.adapter Faraday.default_adapter
      end
    end

    def authorization_url
      params = {
        client_id: @client_id,
        response_type: 'code',
        redirect_uri: @ru_name,
        scope: scopes,
        prompt: 'login'
      }

      "#{AUTH_URL}?#{params.to_query}"
    end

    def exchange_code_for_tokens(code)
      response = @connection.post do |req|
        req.headers.merge!(authorization_header)
        req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
        req.params = {
          grant_type: 'authorization_code',
          code: code,
          redirect_uri: @ru_name
        }
      end

      response.body
    end

    def refresh_access_token(refresh_token)
      Rails.logger.debug "Attempting to refresh token with: #{refresh_token}"
      response = @connection.post do |req|
        req.headers = authorization_header.merge('Content-Type' => 'application/x-www-form-urlencoded')
        req.body = URI.encode_www_form({
          grant_type: 'refresh_token',
          refresh_token: refresh_token
        })
      end

      Rails.logger.debug "Token refresh response: #{response.body}"
      response.body
    end

    private

    def authorization_header
      credentials = Base64.strict_encode64("#{@client_id}:#{@client_secret}")
      { 'Authorization' => "Basic #{credentials}" }
    end

    def scopes
      [
        'https://api.ebay.com/oauth/api_scope',
        'https://api.ebay.com/oauth/api_scope/sell.inventory',
        'https://api.ebay.com/oauth/api_scope/sell.marketing',
        'https://api.ebay.com/oauth/api_scope/sell.account',
        'https://api.ebay.com/oauth/api_scope/sell.fulfillment'
      ].join(' ')
    end
  end
end

class EbayAuthController < ApplicationController
  def index
    @ebay_auth = current_user.ebay_auth
  end

  def authorize
    redirect_to EbayAuth.authorize_url, allow_other_host: true
  end

  def callback
    code = params[:code]
    client_id = Rails.application.credentials.ebay[:client_id]
    client_secret = Rails.application.credentials.ebay[:client_secret]
    redirect_uri = Rails.application.credentials.ebay[:redirect_uri]

    credentials = Base64.strict_encode64("#{client_id}:#{client_secret}")

    response = Faraday.post('https://api.ebay.com/identity/v1/oauth2/token') do |req|
      req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      req.headers['Authorization'] = "Basic #{credentials}"
      req.body = {
        grant_type: 'authorization_code',
        code: code,
        redirect_uri: redirect_uri
      }
    end

    if response.success?
      data = JSON.parse(response.body)

      ebay_auth = current_user.build_ebay_auth(
        access_token: data['access_token'],
        refresh_token: data['refresh_token'],
        expires_at: Time.current + data['expires_in'].seconds
      )

      if ebay_auth.save
        redirect_to ebay_auth_index_path, notice: 'eBay認証が完了しました'
      else
        redirect_to ebay_auth_index_path, alert: '認証情報の保存に失敗しました'
      end
    else
      redirect_to ebay_auth_index_path, alert: '認証に失敗しました'
    end
  end
end

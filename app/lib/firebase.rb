class Auth::Firebase
  require 'net/http'
  class InvalidTokenError < StandardError; end

  def verify_id_token(token)

    options = {
      algorithm: 'RS256',
      iss: Rails.configuration.x.firebase_auth_token.issuer,
      aud: Rails.configuration.x.firebase_auth_token.audience,
      verify_iss: true,
      verify_aud: true,
      verify_iat: true,
    }

    payload, _ = JWT.decode(token, nil, true, options) do |header|
      cert = fetch_certificates[header['kid']]
      if cert.present?
        OpenSSL::X509::Certificate.new(cert).public_key
      else
        nil
      end
    end

    return payload

  rescue JWT::DecodeError => e
    Rails.logger.error("JWT decode error: #{e.message}")
    raise InvalidTokenError, 'Invalid token'
  end

  private

  CACHE_KEY = 'firebase_auth_certificates'.freeze
  CERTS_URL = 'https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com'.freeze

  # 証明書は毎回取得せずにキャッシュする
  def fetch_certificates
    cached = Rails.cache.read(CACHE_KEY)
    return cached if cached.present?

    uri = URI.parse(CERTS_URL)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.read_timeout = 10

    res = http.request(Net::HTTP::Get.new(uri.request_uri))

    unless res.is_a?(Net::HTTPSuccess)
      Rails.logger.error("Fetch certificates failed: #{res.code} #{res.message}")
      raise 'Fetch certificates failed'
    end

    body = JSON.parse(res.body)
    expires_at = Time.zone.parse(res['expires'])
    Rails.cache.write(CACHE_KEY, body, expires_in: expires_at - Time.current)

    body
  end
end

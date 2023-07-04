class Api::ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate

  def authenticate
    # firebase AuthのJWTを使った認証認可
    authenticate_or_request_with_http_token do |token, options|
      client = Auth::Firebase.new
      payload = client.verify_id_token(token)

      if payload.blank?
        render json: { message: 'token invalid' }, status: :unauthorized
        return false
      end

      @current_user = User.find_by(uid: payload['sub'])
      if @current_user.blank?
        render json: { message: 'token invalid' }, status: :unauthorized
        return false
      end

      return true
    end
  end

end

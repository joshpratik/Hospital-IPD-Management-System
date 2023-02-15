# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(_resource, _options = {})
    render json: {
             status: { code: 200, message: "user signed_in sucessfully",
                       data: current_user,
                       role: current_user.user_detail.role.name,
                       token: response.headers[:Authorization]
                     },
           }, status: :ok
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers["Authorization"].split(" ")[1],
                             Rails.application.credentials.fetch(:secret_key_base)).first
    user = User.find_by(jti: jwt_payload["jti"])
    if user
      render json: {
               status: 200,
               message: "signed out sucessfully",
             }, status: :ok
    else
      render json: {
               status: 401,
               message: "user has no active session",
             }, status: :unauthorized
    end
  end
end

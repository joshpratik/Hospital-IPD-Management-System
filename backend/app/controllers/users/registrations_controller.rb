# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _options = {})
    if resource.persisted?
      render json: {
               status: { code: 200, message: "signup sucessfully", data: resource },
             }, status: :ok
    else
      render json: {
               status: { message: "user not created", errors: resource.errors.full_messages },
             }, status: :unprocessable_entity
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

end

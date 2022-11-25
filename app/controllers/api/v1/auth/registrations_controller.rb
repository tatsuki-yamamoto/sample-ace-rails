class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  private

  def sign_up_params
    params.permit(
      :last_name,
      :first_name,
      :email,
      :password,
      :password_confirmation
    )
  end

  def account_update_params
    params.permit(
      :last_name,
      :first_name,
      :email,
      :current_password,
      :password,
      :password_confirmation,
    )
  end
end

# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController


  private

  # Notice the name of the method
  def sign_up_params
    params.require(:user).permit(:email, :password, :username)
  end
end

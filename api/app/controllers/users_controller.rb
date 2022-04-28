class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.where(["username = ?", params[:id]]).first
  end
end

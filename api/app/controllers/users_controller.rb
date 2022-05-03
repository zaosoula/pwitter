
class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    if is_number?(params[:id])
      @user = User.find(params[:id])
    else
      @user = User.where(["username = ?", params[:id]]).first
    end

    @is_following = Follow.where(["target_id = ? AND source_id = ?", @user.id, current_user.id]).exists?
    @followers = Follow.where(["target_id = ?", @user.id]).count
    @following = Follow.where(["source_id = ?", @user.id]).count
  end

  private

  def is_number? string
    true if Float(string) rescue false
  end  
end

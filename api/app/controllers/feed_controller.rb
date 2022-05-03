class FeedController < ApplicationController
  before_action :authenticate_user!

  def index
    followings = Follow.where(source_id: current_user.id).pluck(:target_id)
    followings << current_user.id
    @posts = Post.where(user_id: followings).order(created_at: "DESC");
  end
end

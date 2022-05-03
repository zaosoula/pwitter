class FeedController < ApplicationController
  before_action :authenticate_user!

  def index
    followings = Follow.where(source_id: current_user.id).pluck(:target_id) # Find all user followed by the current user
    followings << current_user.id # Add current user to the list
    @posts = Post.where(user_id: followings).order(created_at: "DESC"); # Retreive all posts
  end

  def hashtag
    @posts = Post.where(["lower(content) LIKE lower(?)", "%#"+params[:hashtag]+"%"]).order(created_at: "DESC")
  end
end

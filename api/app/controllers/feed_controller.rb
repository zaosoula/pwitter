class FeedController < ApplicationController
  before_action :authenticate_user!

  def index
    followings = Follow.where(source_id: current_user.id).pluck(:target_id) # Find all user followed by the current user
    if followings.length == 0
      @posts = Post.order(created_at: "DESC").all; # Retreive all posts
    else
      followings << current_user.id # Add current user to the list
      @posts = Post.where(user_id: followings).order(created_at: "DESC"); # Retreive all posts from followings
    end
    
  end

  def hashtag
    @posts = Post.where(["lower(content) LIKE lower(?)", "%#"+params['hashtag']+"%"]).order(created_at: "DESC")
  end

  def user
    @posts = Post.where(user_id: find_user_id).order(created_at: "DESC")
  end

  private
    # Only allow a list of trusted parameters through.
    def follow_params
      params.require(:follow).permit('target_id').merge(source_id: current_user.id)
    end

    def is_number? string
      true if Float(string) rescue false
    end  

    # Find an user using either its id or username
    def find_user_id
      if is_number?(params['id'])
        return params['id']
      else
        return User.where(username: params['id']).first.id
      end
    end
end

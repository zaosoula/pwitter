class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: %i[ followers followings ]

  # GET /follows
  # GET /follows.json
  def index
    @follows = Follow.where(["source_id = ?", current_user.id]).except(:updated_at).all
  end

  def followings
    # Retreive all users followed by the @user
    @follows = Follow.where(["source_id = ?", @user.id]).except(:updated_at).all
  end

  def followers
    # Retreive all users following the @user
    @follows = Follow.where(["target_id = ?", @user.id]).except(:updated_at).all
  end

  # POST /follows
  # POST /follows.json
  def create
    @follow = Follow.new(follow_params)
    
    if !@follow.save
      render json: @follow.errors, status: :unprocessable_entity
    end
  end

  # DELETE /follows/1
  # DELETE /follows/1.json
  def destroy
    Follow.where(["target_id = ? AND source_id = ?", params[:id], current_user.id]).destroy_all
  end

  private
    # Only allow a list of trusted parameters through.
    def follow_params
      params.permit(:target_id).with_defaults(target_id: find_user_id(params[:id])).merge(source_id: current_user.id)
    end

    def is_number? string
      true if Float(string) rescue false
    end  

    def find_user_id id
      if is_number?(params['id'])
        return params['id']
      else
        return User.where(username: params['id']).first&.id
      end
    end

    # Find an user using either its id or username
    def find_user
      if is_number?(params[:id])
        @user = User.find(params[:id])
      else
        @user = User.where(["username = ?", params[:id]]).first
      end
    end
end

class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: %i[ followers followings ]

  # GET /follows
  # GET /follows.json
  def index
    @follows = Follow.where(["source_id = ?", current_user.id]).except(:updated_at).all
  end

  def followings
    @follows = Follow.where(["source_id = ?", @user.id]).except(:updated_at).all
  end

  def followers
    puts @user.id
    @follows = Follow.where(["target_id = ?", @user.id]).except(:updated_at).all
  end

  # POST /follows
  # POST /follows.json
  def create
    puts follow_params
    @follow = Follow.new(follow_params)
    
    if @follow.save
      render :show, status: :created, location: @follow
    else
      render json: @follow.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /follows/1
  # PATCH/PUT /follows/1.json
  def update
    if @follow.update(follow_params)
      render :show, status: :ok, location: @follow
    else
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
      params.require(:follow).permit(:target_id).merge(source_id: current_user.id)
    end

    def is_number? string
      true if Float(string) rescue false
    end  

    def find_user
      if is_number?(params[:id])
        @user = User.find(params[:id])
      else
        @user = User.where(["username = ?", params[:id]]).first
      end
    end
end

class LikesController < ApplicationController
  before_action :authenticate_user!

  # POST /likes
  # POST /likes.json
  def create
    @like = Like.new(like_params)

    if !@like.save
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  # DELETE /likes/1
  # DELETE /likes/1.json
  def destroy
    Like.where(post_id: params['id'], user_id: current_user.id).destroy_all
  end

  private
    # Only allow a list of trusted parameters through.
    def like_params
      params.permit(:post_id).with_defaults(post_id: params[:id]).merge(user_id: current_user.id)
    end
end

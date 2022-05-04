class PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]
  before_action :authenticate_user!

  def create    
    @post = Post.new(post_params)

    if @post.save
      parse_hashtags
      parse_mentions
      render :show, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:content, :repost_id).with_defaults(content: '', repost_id: nil).merge(user_id: current_user.id)
    end

    def parse_hashtags
      @post.content.scan(/#([\w\d_]+)/).each do |hashtag|
        puts hashtag
      end

      puts @post
    end

    def parse_mentions

    end
end

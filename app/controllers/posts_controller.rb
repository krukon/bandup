class PostsController < ApplicationController
  before_action :signed_in_user
  before_action :filter_post, only: [:show, :destroy]
  before_action :filter_owner, only: [:destroy]

  def index
    @recent = Post.order("id DESC").limit(20)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.artist = current_user
    @post.save
  end

  def show
    
  end

  def destroy
    @post.destroy
    redirect_to :back
  end

  private

    def post_params
      params.require(:post).permit(:content, :link, :picture)
    end

    def filter_post
      @post = Post.find_by(id: params[:id])
      unless @post
        flash[:error] = "Such post does not exist."
        redirect_to posts_path
      end
    end

    def filter_owner
      @artist = current_user
      unless @post.artist == @artist or (@post.band != nil &&
          @artist.band_relations.find_by(band_id: @post.band, owner: true))
        flash[:error] = "You do not have permission to modify this post."
        redirect_to posts_path
      end
    end

end

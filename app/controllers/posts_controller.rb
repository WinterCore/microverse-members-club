class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_posts, only: %i[index create edit]
  before_action :authorize_user, only: %i[edit update destroy]

  def index
    @post = Post.new
  end

  def edit
    render 'index'
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      render :index
    end
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: 'Post was successfully updated.'
    else
      render :index
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'Post was successfully destroyed.'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_posts
    @posts = Post.order('created_at DESC')
  end

  def authorize_user
    return unless @post.user_id != current_user.id
    flash[:alert] = 'You\'re not supposed to be here'
    redirect_to posts_path
  end

  def post_params
    params.require(:post).permit(:body, :user_id)
  end
end

class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
    @comments = @post.comments
    # remember, the setting of the post is now comings from the 'set_post' methond and 'before_action' call above
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = User.first.id # TODO:  Change once we have authentication.
    
    if @post.save
      flash[:notice] = "Your post was created"
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    # remember, the setting of the post is now comings from the 'set_post' methond and 'before_action' call above
  end

  def update
    #binding.pry
    # remember, the setting of the post is now comings from the 'set_post' methond and 'before_action' call above
    if @post.update(post_params)
      flash[:notice] = "Your post was updated"
      redirect_to posts_path
    else
      render :edit
    end
  end

private
  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

end 




class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:show, :index]  # require user comes from application controller

  def index
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.sort_by{|x| x.total_votes}.reverse
    # remember, the setting of the post is now comings from the 'set_post' methond and 'before_action' call above
  end

  def new
    @post = Post.new
    
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    
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

  def vote
    vote = Vote.create(voteable: @post, user: current_user, vote: params[:vote])
    

    if vote.valid?
      flash[:notice] = "Your vote was counted."
    else
      flash[:error] = "You can only vote on a post once"
    end
    redirect_to :back  # rails will know where you came from
    
  end

private
  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

end 




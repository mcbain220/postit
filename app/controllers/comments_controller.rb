class CommentsController < ApplicationController

before_action :require_user

def create
 
  @post = Post.find(params[:post_id])

  @comment = Comment.new(post_params)
  @comment.user_id = current_user.id
  @comment.post = @post

  #alternative to above:  @post.comments.build(params.require(:comment).permit(:body))

  if @comment.save
      flash[:notice] = "Your comment was created"
      redirect_to post_path(@post)
    else
      render 'posts/show'  #render view template that you submitted from (think controller action)
    end
end

def vote
  comment = Comment.find(params[:id])
  vote = Vote.create(voteable: comment, user: current_user, vote: params[:vote])
  #binding.pry
  if vote.valid?
    flash[:notice] = "Your vote was counted."
  else
    flash[:errors] = "You can only vote on a comment once."
  end
    redirect_to :back  # rails will know where you came from
end


private

def post_params
  params.require(:comment).permit(:body)
end

end

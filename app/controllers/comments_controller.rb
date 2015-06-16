class CommentsController < ApplicationController


def create
 
  @post = Post.find(params[:post_id])

  @comment = Comment.new(post_params)
  @comment.user_id = 1  #TODO:  fix after authentication
  @comment.post = @post

  #alternative to above:  @post.comments.build(params.require(:comment).permit(:body))

  if @comment.save
      flash[:notice] = "Your comment was created"
      redirect_to post_path(@post)
    else
      render 'posts/show'  #render view template that you submitted from (think controller action)
    end
end


private

def post_params
  params.require(:comment).permit(:body)
end

end

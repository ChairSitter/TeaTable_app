class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id

    if comment.save
      redirect_to post_path(comment.post_id)
    else
      redirect_to post_path(comment.post_id), alert: "Comment not saved."
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to post_path(comment.post_id)
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end

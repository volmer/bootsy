# frozen_string_literal: true
class CommentsController < ApplicationController
  def create
    @post = Post.find params[:post_id]
    @comment = @post.comments.new(comment_params)

    if @comment.save
      redirect_to @post, notice: 'Comment was created.'
    else
      render 'new'
    end
  end

  def destroy
    @post = Post.find params[:post_id]
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to @post
  end

  def update
    @post = Post.find params[:post_id]
    @comment = @post.comments.find(params[:id])

    if @comment.update_attributes(comment_params)
      redirect_to @post, notice: 'Comment was updated.'
    else
      redirect_to @post, alert: 'Unable to update comment.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:author, :content)
  end
end

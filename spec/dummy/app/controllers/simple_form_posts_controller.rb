# frozen_string_literal: true
class SimpleFormPostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was created.'
    else
      render 'new'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :bootsy_image_gallery_id)
  end
end

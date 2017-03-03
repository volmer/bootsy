# frozen_string_literal: true
class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new

    return unless params[:with_comment]

    @post.comments << Comment.new
    render 'new_with_comment'
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was created.' }
        format.json { render json: { post: post_view_string } }
      else
        format.html { render 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(post_params)
      redirect_to @post, notice: 'Post was updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_url
  end

  private

  def post_params
    params.require(:post).permit(
      :title,
      :content,
      :bootsy_image_gallery_id,
      comments_attributes: [:content, :author]
    )
  end

  def post_view_string
    render_to_string(
      file: 'posts/_post',
      formats: [:html],
      layout: false,
      locals: { post: @post }
    )
  end
end

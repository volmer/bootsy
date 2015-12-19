class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new

    if params[:with_comment]
      @post.comments << Comment.new
      render(action: 'new_with_comment')
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: { post: render_to_string(file: 'posts/_post', formats: [:html], layout: false, locals: { post: @post }) } }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
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
    params.require(:post).permit(:title, :content, bootsy_image_ids: [], comments_attributes: [:content, :author])
  end
end

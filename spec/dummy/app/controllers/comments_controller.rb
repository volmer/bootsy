class CommentsController < ApplicationController

  # POST /comments
  # POST /comments.json
  def create
    @post = Post.find params[:post_id]
    @comment = @post.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @post = Post.find params[:post_id]
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @post }
      format.json { head :no_content }
    end
  end

  def update
    @post = Post.find params[:post_id]
    @comment = @post.comments.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(comment_params)
        format.html { redirect_to @post, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @post, alert: 'Unable to update comment.' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:author, :content)
  end
end

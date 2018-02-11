class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end
	
	def opinions
	 @comments = current_user.comments.paginate(page: params[:page], :per_page => 33).order('created_at DESC') 
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
	@post = Post.find(params[:post_id])
  @comment = Comment.new
	# @comment.parent_id = params[:parent_id]
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
	@post = Post.find(params[:post_id])
  @comment = @post.comments.build(comment_params)
	@comment.user_id = current_user.id
	@comment.post_id = @post.id
    respond_to do |format|
      if @comment.save
		format.js
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
	@post = Post.find(params[:post_id])
	@comment = @post.comments.find(params[:id])
    if @comment.destroy
    respond_to do |format|
	  format.js
      #format.html { redirect_to @post, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end

def like
	@post = Post.find(params[:post_id])
	@comment = @post.comments.find(params[:comment_id])
  @comment.liked_by current_user
  respond_to do |format|
    format.html { redirect_to @post }
	 format.js
  end
 end

  def dislike
	  @post = Post.find(params[:post_id])
	@comment = @post.comments.find(params[:comment_id])
  @comment.disliked_by current_user
  respond_to do |format|
    format.html { redirect_to @post }
    format.js
    end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @post = Post.find(params[:post_id])
	    @comment = @post.comments.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:post_id, :user_id, :body, :ancestry)
    end
end

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]
  before_action :set_parent_id, only: %i[new]
  before_action :set_commentable

  def index
    @comments = @commentable.comments.ordered
  end

  def new
    @comment = @commentable.comments.build
  end

  def create
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @commentable, notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /comments/1 or /comments/1.json
  def show; end

  # GET /comments/1/edit
  def edit; end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_back_or_to root_path, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
      format.turbo_stream
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_parent_id
    @parent_id = params[:parent_id]
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:content, :parent_id)
  end
end

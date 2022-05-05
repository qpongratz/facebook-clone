# frozen_string_literal:  true

module Posts
  class CommentsController < CommentsController
    before_action :build_comment, only: %i[create]

    def index
      @comments = @commentable.comments.all
    end

    def new
      @comment = @commentable.comments.build
    end

    def create
      respond_to do |format|
        if @comment.save
          format.html { redirect_to @commentable, notice: "Comment was successfully created." }
          format.json { render :show, status: :created, location: @comment }
          #format.turbo_stream
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def build_comment
      @comment = @commentable.comments.build(comment_params)
      @comment.user = current_user
    end

    def set_commentable
      @commentable = Post.find(params[:post_id]) if params[:post_id]
    end
  end
end

# frozen_string_literal:  true

module Posts
  class CommentsController < CommentsController
    before_action :build_comment, only: %i[create]

    private

    def build_comment
      @comment = @commentable.comments.build(comment_params)
      @comment.user = current_user
    end

    def set_commentable
      @commentable = Post.find(params[:post_id])
    end
  end
end

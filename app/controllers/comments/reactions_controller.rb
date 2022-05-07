# frozen_string_literal:  true

module Comments
  class ReactionsController < ReactionsController
    def set_reactable
      @reactable = Post.find(params[:comment_id]) if params[:comment_id]
    end
  end
end

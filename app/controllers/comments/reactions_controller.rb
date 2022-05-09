# frozen_string_literal:  true

module Comments
  class ReactionsController < ReactionsController
    def set_reactable
      @reactable = Comment.find(params[:comment_id])
    end
  end
end

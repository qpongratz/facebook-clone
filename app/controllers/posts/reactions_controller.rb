# frozen_string_literal:  true

module Posts
  class ReactionsController < ReactionsController
    def set_reactable
      @reactable = Post.find(params[:post_id])
    end
  end
end

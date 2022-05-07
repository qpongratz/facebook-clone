# frozen_string_literal:  true

module Posts
  class ReactionsController < ApplicationController
    before_action :build_reaction, only: %i[create]
    before_action :set_reactable, except: %i[destroy]
    before_action :set_reaction, only: %i[destroy]

    def index
      @reactable.reactions.all
    end

    def create
      build_reaction

      if @reaction.save
        redirect_to @reactable, notice: 'You liked it'
      else
        redirect_back_or_to root_path, notice: 'Something went wrong'
      end
    end

    def destroy
      @reaction.destroy
    end

    private

    def set_reaction
      @reaction = Reaction.find(params[:id])
    end

    def build_reaction
      @reaction = @reactable.comments.build
      @reaction.user = current_user
    end
  end
end

# frozen_string_literal:  true

class ReactionsController < ApplicationController
  before_action :set_reactable, except: %i[destroy]
  before_action :set_reaction, only: %i[destroy]

  def index
    @reactions = @reactable.reactions.includes(:user)
  end

  def create
    build_reaction

    if @reaction.save
      redirect_back_or_to root_path, notice: 'You liked it'
    else
      redirect_back_or_to root_path, notice: 'Something went wrong'
    end
  end

  def destroy
    @reaction.destroy

    redirect_back_or_to root_path, notice: 'Unliked!'
  end

  private

  def set_reaction
    @reaction = Reaction.find(params[:id])
  end

  def build_reaction
    @reaction = @reactable.reactions.build
    @reaction.user = current_user
  end
end

# frozen_string_literal:  true

class ReactionsController < ApplicationController
  before_action :set_reactable, except: %i[destroy]
  before_action :set_reaction, only: %i[destroy]
  before_action :authorize_user, only: %i[destroy]

  def index
    @reactions = @reactable.reactions.includes(:user)
  end

  def create
    build_reaction

    if @reaction.save
      respond_to do |format|
        format.html { redirect_back_or_to root_path, notice: 'You liked it' }
        format.turbo_stream { flash.now[:notice] = 'Liked!'}
      end
    else
      redirect_back_or_to root_path, notice: 'Something went wrong'
    end
  end

  def destroy
    @reactable = @reaction.reactable
    @reaction.destroy

    respond_to do |format|
      format.html { redirect_back_or_to root_path, notice: 'Unliked!' }
      format.turbo_stream { flash.now[:notice] = 'Unliked!'}
    end
  end

  private

  def authorize_user
    return if current_user == @reaction.user

    flash[:error] = 'Not authorized'
    redirect_back_or_to root_path
  end

  def set_reaction
    @reaction = Reaction.find(params[:id])
  end

  def build_reaction
    @reaction = @reactable.reactions.build
    @reaction.user = current_user
  end
end

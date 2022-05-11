class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[update destroy]

  def destroy
    @friendship.destroy
    respond_to do |format|
      format.html { redirect_back_or_to root_path, notice: 'Successfully unfriended' }
      format.turbo_stream
    end
  end

  private

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end
end

class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[destroy]
  before_action :find_turbo_user, only: %i[destroy]

  def index
    @user = User.find(params[:user_id])
    @friends = @user.friends
  end

  def destroy
    @friendship.destroy
    respond_to do |format|
      format.html { redirect_back_or_to root_path, notice: 'Successfully unfriended' }
      format.turbo_stream { render 'shared/friend_button_update' }
    end
  end

  private
  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def find_turbo_user
    @user = (current_user == @friendship.user ? @friendship.friend : @friendship.user)
  end
end

class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friendship_params)

    if @friendship.save
      redirect_back_or_to root_path, notice: 'Friend request sent'
    else
      redirect_back_or_to root_path, notice: 'Something went wrong'
    end
  end

  def destroy
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end
end

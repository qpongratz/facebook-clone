class FriendshipsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @friendship = Friendship.new
  end

  def create
    @user = User.find(params[:user_id])
    @friendship = current_user.outgoing_friendships.build
    @friendship.friend = @user

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

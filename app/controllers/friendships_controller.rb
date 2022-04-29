class FriendshipsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @friendship = Friendship.new
  end

  def create
    @friendship = current_user.outgoing_friendships.build(friend_id: params[:user_id])

    if @friendship.save
      redirect_back_or_to root_path, notice: 'Friend request sent'
    else
      redirect_back_or_to root_path, notice: 'Something went wrong'
    end
  end

  def edit
    @friendship = Friendship.find(params[:friendship_id])
  end

  def update
    @friendship = Friendship.find(params[:friendship_id])
  end

  def destroy
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id, :status)
  end
end

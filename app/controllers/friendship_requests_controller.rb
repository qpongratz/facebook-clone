class FriendshipRequestsController < ApplicationController
  before_action :set_friendship_request, only: %i[destroy accept]
  before_action :find_turbo_user, only: %i[destroy]

  def create
    @user = User.find(params[:user_id])
    @friendship_request = current_user.outgoing_requests.build(receiver: @user)

    if @friendship_request.save
      respond_to do |format|
        format.html { redirect_back_or_to root_path, notice: 'Friend request sent' }
        format.turbo_stream { render 'shared/friend_button_update' }
      end
    else
      redirect_back_or_to root_path, alert: 'Something went wrong'
    end
  end

  def accept
    @user = @friendship_request.requester
    @friendship = current_user.friendships.build(friend: @user)

    if @friendship.save
      @friendship_request.destroy
      respond_to do |format|
        format.html { redirect_back_or_to root_path, notice: 'Friendship accepted' }
        format.turbo_stream { render 'shared/friend_button_update' }
      end
    else
      redirect_back_or_to root_path alert: 'Uh-oh, something went wrong'
    end
  end

  def destroy
    @friendship_request.destroy
    respond_to do |format|
      format.html { redirect_back_or_to root_path, notice: 'Request deleted' }
      format.turbo_stream { render 'shared/friend_button_update' }
    end
  end

  private

  def find_turbo_user
    @user = (current_user == @friendship_request.receiver ? @friendship_request.requester : @friendship_request.receiver)
  end

  def set_friendship_request
    @friendship_request = FriendshipRequest.find(params[:id])
  end
end

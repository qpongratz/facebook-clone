class FriendshipRequestsController < ApplicationController
  before_action :set_friendship_request, only: %i[destroy accept]
  before_action :set_participants

  def create
    @user_id = params[:user_id]
    @friendship_request = current_user.outgoing_requests.build(receiver_id: @user_id)

    if @friendship_request.save
      respond_to do |format|
        format.html { redirect_back_or_to root_path, notice: 'Friend request sent' }
        format.turbo_stream
      end
    else
      flash.now[:alert] = 'Something went wrong'
      render :new, status: :unprocessable_entity
    end
  end

  def accept
    @friendship = @requester.friendships.build(friend: @receiver)

    if @friendship.save
      @friendship_request.destroy
      redirect_back_or_to root_path, notice: 'Friendship accepted'
    else
      redirect_back_or_to root_path alert: 'Uh-oh, something went wrong'
    end
  end

  def destroy
    @friendship_request.destroy
    respond_to do |format|
      format.html { redirect_back_or_to root_path, notice: 'Request deleted' }
      format.turbo_stream
    end
  end

  private

  def set_participants
    @requester = @friendship_request.requester
    @receiver = @friendship_request.receiver
  end

  def set_friendship_request
    @friendship_request = FriendshipRequest.find(params[:id])
  end
end

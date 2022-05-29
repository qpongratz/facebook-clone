class FriendshipRequestsController < ApplicationController
  before_action :set_user, only: %i[index create]
  before_action :set_friendship_request, only: %i[destroy accept]
  before_action :find_turbo_user, only: %i[destroy]

  def index
    authorize_user
    @incoming_requests = @user.incoming_requests.includes(:requester)
    @outgoing_requests = @user.outgoing_requests.includes(:receiver)
  end

  def create
    @friendship_request = current_user.outgoing_requests.build(receiver: @user)

    if @friendship_request.save
      respond_to do |format|
        format.html { redirect_back_or_to root_path, notice: 'Friend request sent' }
        format.turbo_stream do
          flash.now[:notice] = 'Friend request sent'
          render 'shared/friend_button_update'
        end
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
        format.turbo_stream do
          flash.now[:notice] = 'Friendship accepted'
          render 'shared/friend_button_update'
        end
      end
    else
      redirect_back_or_to root_path alert: 'Uh-oh, something went wrong'
    end
  end

  def destroy
    @friendship_request.destroy
    respond_to do |format|
      format.html { redirect_back_or_to root_path, notice: 'Friend request deleted' }
      format.turbo_stream do
        flash.now[:notice] = 'Friend request deleted'
        render 'shared/friend_button_update'
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def find_turbo_user
    @user = (current_user == @friendship_request.receiver ? @friendship_request.requester : @friendship_request.receiver)
  end

  def set_friendship_request
    @friendship_request = FriendshipRequest.find(params[:id])
  end

  def authorize_user
    return if @user == current_user

    redirect_back_or_to root_path, error: 'Not authorized'
  end
end

class FriendshipsController < ApplicationController
  before_action :set_user
  before_action :set_friendship, only: %i[update destroy]

  def index
    @pending_incoming = @user.pending_incoming
    @pending_outgoing = @user.pending_outgoing
    @active_friends = @user.active_friends
  end

  def create
    @friendship = current_user.outgoing_friendships.build(friend_id: @user.id)

    if @friendship.save
      respond_to do |format|
        format.html { redirect_back_or_to root_path, notice: 'Friend request sent' }
        format.turbo_stream
      end
    else
      flash.now[:alert] = 'Something went wrong'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @friendship.update(status: :accepted)
      respond_to do |format|
        format.html { redirect_back_or_to root_path, notice: 'Friend request accepted' }
        format.turbo_stream
      end
    else
      flash.now[:alert] = 'Something went wrong'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @friendship.destroy
    respond_to do |format|
      format.html { redirect_back_or_to root_path, notice: 'Successfully unfriended' }
      format.turbo_stream
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end
end

class FriendshipsController < ApplicationController
  before_action :set_user, only: %i[index create]
  before_action :set_friendship, only: %i[update destroy]

  def index

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
      redirect_back_or_to root_path, notice: 'Friend request accepted'
    else
      flash.now[:alert] = 'Something went wrong'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @friendship.destroy
    redirect_back_or_to root_path, notice: 'Successfully unfriended'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end
end

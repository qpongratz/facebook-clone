class FriendshipsController < ApplicationController
  before_action :set_user
  before_action :set_friendship, except: %i[new create index]

  def show

  end

  def index

  end

  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = current_user.outgoing_friendships.build(friend_id: @user.id)

    if @friendship.save
      redirect_to users_path, notice: 'Friend request sent'
    else
      flash.now[:alert] = 'Something went wrong'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @friendship.update(status: :accepted)
      redirect_to root_path, notice: 'Friend request accepted'
    else
      flash.now[:alert] = 'Something went wrong'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @friendship.destroy
    redirect_to root_path, notice: 'Successfully unfriended'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end
end

class UsersController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @users = pagy(User.includes(:friendships, :incoming_requests, :outgoing_requests).all_except(current_user))
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id)
                 .includes(:user, :reactions, comments: %i[user reactions])
  end
end

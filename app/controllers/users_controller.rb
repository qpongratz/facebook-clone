class UsersController < ApplicationController
  include Pagy::Backend
  before_action :set_user, except: :index

  def index
    @pagy, @users = pagy(User.includes(:friendships, :incoming_requests, :outgoing_requests).all_except(current_user))
  end

  def show
    @posts = Post.where(user_id: @user.id)
                 .includes(:user, :reactions, comments: %i[user reactions])
  end

  def card
    render layout: false
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end

class UsersController < ApplicationController
  before_action :set_user, except: :index

  def index
    @pagy, @users = pagy(User.all_except(current_user))
  end

  def show
    @posts = Post.where(user_id: @user.id)
                 .includes(:user, :reactions)
  end

  def card
    respond_to do |format|
      format.html
      format.turbo_stream { render layout: false }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end

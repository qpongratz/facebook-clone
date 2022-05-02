class UsersController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @users = pagy(User.all_except(current_user))
  end

  def show
    @user = User.find(params[:id])
  end
end

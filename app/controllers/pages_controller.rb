class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    return unless current_user

    redirect_to posts_path
  end
end

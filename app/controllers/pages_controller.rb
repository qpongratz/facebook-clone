class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    current_user ? (redirect_to posts_path) : (render layout: 'landing_page')
  end
end

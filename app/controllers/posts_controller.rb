class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authorize_user, only: %i[edit update destroy]

  # GET /posts or /posts.json
  def index
    @pagy, @posts = pagy_countless(Post.includes(:user, :reactions)
                                    .friends_posts(current_user)
                                    .newest_first)
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.includes(:user, comments: %i[user reactions])
                .find(params[:id])
    # Add check here for if user is authorized to actually see this post
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
        format.turbo_stream { flash.now[:notice] = 'Post was successfully created.'}
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
        format.turbo_stream { flash.now[:notice] = 'Post was successfully updated.'}
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully deleted." }
      format.json { head :no_content }
      format.turbo_stream { flash.now[:notice] = 'Post was successfully deleted.'}
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user
    return if current_user == @post.user

    flash[:error] = 'Not authorized'
    redirect_back_or_to root_path
  end

  def post_params
    params.require(:post).permit(:content, :user_id)
  end
end

class PostsController < ApplicationController
    before_action :find_post, only: [:edit, :update, :show, :destroy]

  # Index action to render all posts
  def index
    @posts = Post.order("created_at DESC")
  end
  
  def sort_data
    # if params[:key].present?
    if params[:key].present? and params[:key] == "letest"
      @posts = Post.order("created_at DESC")
    elsif params[:key].present? and params[:key] == "popular"
      @posts = Post.order("count DESC")
    else
      @posts = nil
    end
    respond_to do |format|
      format.js # actually means: if the client ask for js -> return file.js
    end
  end
  
  def search
    @posts = Post.where("title like ?", "#{params[:key]}%")
    respond_to do |format|
      format.js # actually means: if the client ask for js -> return file.js
    end
  end
  
  # New action for creating post
  def new
    @post = Post.new
  end

  # Create action saves the post into database
  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "Successfully created post!"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Error creating new post!"
      render :new
    end
  end

  # Edit action retrives the post and renders the edit page
  def edit
  end

  # Update action updates the post with the new information
  def update
    if @post.update_attributes(post_params)
      flash[:notice] = "Successfully updated post!"
      redirect_to post_path(@posts)
    else
      flash[:alert] = "Error updating post!"
      render :edit
    end
  end

  # The show action renders the individual post after retrieving the the id
  def show
    @post.update_attributes(count: @post.count + 1)
  end

  # The destroy action removes the post permanently from the database
  def destroy
    if @post.destroy
      flash[:notice] = "Successfully deleted post!"
      redirect_to posts_path
    else
      flash[:alert] = "Error updating post!"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end

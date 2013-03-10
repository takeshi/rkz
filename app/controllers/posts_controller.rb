class PostsController < ApplicationController
  before_filter :authenticate_user!, :except =>[:index,:show]
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])

    unless @post.owner.id == current_user.id
      respond_to do |format|
        format.html { redirect_to @post, notice: '更新権限がありません' }
        format.json { render json: {:messages=>["unauthenticated"]}, status: :unauthenticated }
      end
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.owner = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.owner.id != current_user.id
        format.html { redirect_to @post, notice: '更新権限がありません' }
        format.json { render json: {:messages=>["unauthenticated"]}, status: :unauthenticated }
      elsif @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: '更新しました' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])

    unless @post.owner.id == current_user.id
      respond_to do |format|
        format.html { redirect_to @post, notice: '更新権限がありません' }
        format.json { head :no_content }
      end
    else 
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url }
        format.json { head :no_content }
      end
    end
  end
end

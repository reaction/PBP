class PostsController < ApplicationController
  require 'dicebox'
  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end
  def add_dice
    #@game = current_game 
    @game = Game.find(params[:game_id])
    @post = @game.posts.build(params[:post])
    @post.user_id = current_user.id
    @post.action = "Dice"
    @post.subject = "Die Roll"
    logger.debug "Logging!"
    logger.debug params[:die_roll]
    logger.debug params[:message]
    #dice = Dicebox::Dice.new(params[:die_roll])
    dice = Dicebox::Dice.new(params[:die_roll])
    @post.message =  dice.roll
    #@game.posts.build(:user_id => current_user.id)
    respond_to do |format|
    if @post.save
    format.html { redirect_to(@post.game,
    :notice => '') }
    format.xml { render :xml => @post,
    :status => :created, :location => @post }
    else
    format.html { render :action => "new" }
    format.xml { render :xml => @post.errors,
    :status => :unprocessable_entity }
    end
  end
  end
  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    game = Game.find(params[:game_id])
    session[:game_id] = game.id
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @game = current_game 
    #game = Game.find(params[:game_id])
    @post = @game.posts.build(params[:post])
    @post.user_id = current_user.id
    #@game.posts.build(:user_id => current_user.id)
    respond_to do |format|
    if @post.save
    format.html { redirect_to(@post.game,
    :notice => '') }
    format.xml { render :xml => @post,
    :status => :created, :location => @post }
    else
    format.html { render :action => "new" }
    format.xml { render :xml => @post.errors,
    :status => :unprocessable_entity }
    end
  end
end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
end

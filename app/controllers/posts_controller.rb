class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_ownership, only: [:edit, :update, :destroy]
  
  def index
    
    @posts = Post.order('created_at DESC').paginate(:page => params[:page], :per_page => 6)
 # @posts=d_post.sort
    
    @posts_count = current_user.posts.length
    # @posts = Post.page params[:page]
  end

  def new
    @post = Post.new
  end

  def create
    Post.create( title: params[:post][:title], content: params[:post][:content], image: params[:post][:image], user_id: current_user.id)
    redirect_to '/posts'
  end
  
  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post= Post.find(params[:id])
    @post.update_attributes(title: params[:post][:title], content: params[:post][:content])
    redirect_to '/posts'
  end

  def show
   @post = Post.find(params[:id])
   #post에 있는 user의 id를 받아와야 함
   p_user= @post.user_id
   
   @post_user= User.find_by(id: p_user)
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to '/posts'
  end
  
  def check_ownership
      @post = Post.find_by(id: params[:id])
      redirect_to root_path if @post.user.id != current_user.id    
  end
  
end

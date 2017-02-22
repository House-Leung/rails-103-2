class PostsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create, :update, :destroy]

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end

    def edit
      @group = Group.find(params[:group_id])
      #对照group，多了以上这行
      @post = Post.find(params[:id])
      @post.group = @group
    end

    def update
      @group = Group.find(params[:group_id])
      #对照group，多出了以上这行，为什么？
      @post = Post.find(params[:id])
      #对照论坛来
      @post.group = @group
      @post.user = current_user

      #在助教@mike 的帮助下，增加了if－else语句，
      #为什么是 account_posts_path ?而不是 group_path(@group)
      if @post.update(post_params)
        redirect_to account_posts_path, notice: "Update Success"
      else
      # 为什么是加上这个？
        render :edit
      end
    end

    def destroy
      @group = Group.find(params[:group_id])
      @post = Post.find(params[:id])
      @post.group = @group
      @post.destroy
      flash[:alert] = "Group deleted"
      redirect_to account_posts_path
    end


end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end

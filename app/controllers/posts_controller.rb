class PostsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create]

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
    end

    def update
      @group = Group.find(params[:group_id])
      #对照group，多出了以上这行，为什么？
      @post = Post.find(params[:id])

      #在助教@mike 的帮助下，增加了if－else语句，
      if @post.update(post_params)
        redirect_to group_path(@group), notice: "Update Success"
      else
      # 为什么是加上这个？
        render :edit
      end
    end


end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end

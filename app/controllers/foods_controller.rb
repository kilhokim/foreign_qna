class FoodsController < ApplicationController
	before_action :login_check
	skip_before_action :login_check, :only => [:posts, :posts_category, :show]

  def posts
		@posts = Post.all
  end

  # ------- Unused action
  def posts_category
    @category = params[:category]
    @posts = Post.where(category: @category)
  end
  # ------- end of unused action

  def show
		post = Post.find(params[:id])
    post.views += 1
    post.save
    @post = post
		@comment_writer = User.where(id: session[:user_id])[0]
  end

  def vote_up_complete
    post = Post.find(params[:id])
    post.votes += 1
    post.save
    redirect_to :back
  end

  def vote_down_complete
    post = Post.find(params[:id])
    if (post.votes > 0)
      post.votes -= 1
      post.save
    else
			flash[:alert] = "비추를 할 수 없습니다."
    end
    redirect_to :back
  end

  def write
  end

  def write_complete
    post = Post.new
		post.user_id = session[:user_id]
    post.category = params[:post_category]
    post.title = params[:post_title]
    post.content = params[:post_content]
    post.views = 0
    post.votes = 0
    if post.save
      flash[:alert] = "저장되었습니다."
      redirect_to "/foods/show/#{post.id}"
    else
      flash[:alert] = post.errors.values.flatten.join(' ')
      redirect_to :back
    end
  end

  def edit
		@post = Post.find(params[:id])
    if @post.user_id != session[:user_id]
      flash[:alert] = "수정 권한이 없습니다."
      redirect_to :back
    end
  end

  def edit_complete
    post = Post.find(params[:id])
    post.category = params[:post_category]
    post.title = params[:post_title]
    post.content = params[:post_content]
    post.views = 0
    post.votes = 0
    if post.save
      flash[:alert] = "수정되었습니다."
      redirect_to "/foods/show/#{post.id}"
    else
      flash[:alert] = post.errors.values.flatten.join(' ')
      redirect_to :back
    end
  end

  def delete_complete
    post = Post.find(params[:id])
		if post.user_id == session[:user_id]
			post.destroy
			flash[:alert] = "삭제되었습니다."
			redirect_to "/"
		else
			flash[:alert] = "삭제 권한이 없습니다."
			redirect_to :back
		end
  end

  def write_comment_complete
    comment = Comment.new
		comment.user_id = session[:user_id]
    comment.post_id = params[:post_id]
    comment.content = params[:comment_content]
    comment.votes = 0
    comment.save

    flash[:alert] = "새 댓글을 달았습니다."
    redirect_to "/foods/show/#{comment.post_id}"
  end

	def delete_comment_complete
    comment = Comment.find(params[:id])
		if comment.user_id == session[:user_id]
			comment.destroy
			flash[:alert] = "댓글이 삭제되었습니다."
			redirect_to "/foods/show/#{comment.post_id}"
		else
			flash[:alert] = "해당 댓글의 삭제 권한이 없습니다."
			redirect_to :back
		end
	end
end

class FoodsController < ApplicationController
	before_action :login_check
	skip_before_action :login_check, :only => [:posts, :posts_category, :show]

  def posts
    @tab = params[:tab]
    case @tab
      when nil
        @posts = Post.order(votes: :desc)
      when "hot"
        @posts = Post.order(votes: :desc)
      when "popular"
        @posts = Post.order(views: :desc)
      when "today"
        @posts = Post.order(created_at: :desc).where(created_at: Time.at(Time.now.to_i-86400)..Time.now)
      when "week"
        @posts = Post.order(created_at: :desc).where(created_at: Time.at(Time.now.to_i-604800)..Time.now)
      when "alltime"
        @posts = Post.order(created_at: :desc)
    end
  end

  def posts_category
    @category = params[:category]
    @posts = Post.where(category: @category)
  end

  def show
		post = Post.find(params[:id])
    post.views += 1
    post.save
    @post = post
		@comment_writer = User.where(id: session[:user_id])[0]
  end

  def vote_post_up_complete
    v = Votelog.where(:user_id => session[:user_id]).where(:post_id => params[:id]).first
    # If not voted up, first vote up or revote up
    if v.nil?
      v_new = Votelog.new(:user_id => session[:user_id], :post_id => params[:id], :vote_score => 1)
      v_new.save

      post_voted = Post.find_by_id(params[:id])
      post_voted.votes += 1
      post_voted.save
      data = post_voted.votes
      
    elsif v.vote_score <= 0
      v.vote_score += 1
      v.save

      post_voted = Post.find_by_id(params[:id])
      post_voted.votes += 1
      post_voted.save
      data = post_voted.votes

    # If already voted up, no effect
    else
      data = post_voted.votes
    end

    respond_to do |format|
      format.json { render :json => data }
    end
    
  end

  def vote_post_down_complete
    v = Votelog.where(:user_id => session[:user_id]).where(:post_id => params[:id]).first
    # If not voted up, first vote up or revote up
    if v.nil?
      v_new = Votelog.new(:user_id => session[:user_id], :post_id => params[:id], :vote_score => -1)
      v_new.save

      post_voted = Post.find_by_id(params[:id])
      post_voted.votes -= 1
      post_voted.save
      data = post_voted.votes
      
    elsif v.vote_score >= 0
      v.vote_score -= 1
      v.save

      post_voted = Post.find_by_id(params[:id])
      post_voted.votes -= 1
      post_voted.save
      data = post_voted.votes

    # If already voted down, no effect
    else
      data = post_voted.votes
    end

    respond_to do |format|
      format.json { render :json => data }
    end
  end

  def vote_comment_up_complete
    v = Votecommentlog.where(:user_id => session[:user_id]).where(:comment_id => params[:id]).first
    # If not voted up, first vote up or revote up
    if v.nil?
      v_new = Votecommentlog.new(:user_id => session[:user_id], :comment_id => params[:id], :vote_score => 1)
      v_new.save

      comment_voted = Comment.find_by_id(params[:id])
      comment_voted.votes += 1
      comment_voted.save
      data = comment_voted.votes
      
    elsif v.vote_score <= 0
      v.vote_score += 1
      v.save

      comment_voted = Comment.find_by_id(params[:id])
      comment_voted.votes += 1
      comment_voted.save
      data = comment_voted.votes

    # If already voted up, no effect
    else
      data = comment_voted.votes
    end

    respond_to do |format|
      format.json { render :json => data }
    end
  end

  def vote_comment_down_complete
    v = Votecommentlog.where(:user_id => session[:user_id]).where(:comment_id => params[:id]).first
    # If not voted up, first vote up or revote up
    if v.nil?
      v_new = Votecommentlog.new(:user_id => session[:user_id], :comment_id => params[:id], :vote_score => -1)
      v_new.save

      comment_voted = Comment.find_by_id(params[:id])
      comment_voted.votes -= 1
      comment_voted.save
      data = comment_voted.votes
      
    elsif v.vote_score >= 0
      v.vote_score -= 1
      v.save

      comment_voted = Comment.find_by_id(params[:id])
      comment_voted.votes -= 1
      comment_voted.save
      data = comment_voted.votes

    # If already voted down, no effect
    else
      data = comment_voted.votes
    end

    respond_to do |format|
      format.json { render :json => data }
    end
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
      redirect_to "/qna/show/#{post.id}"
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
    if post.save
      flash[:alert] = "수정되었습니다."
      redirect_to "/qna/show/#{post.id}"
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
			redirect_to "/qna"
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
    redirect_to "/qna/show/#{comment.post_id}"
  end

	def delete_comment_complete
    comment = Comment.find(params[:id])
		if comment.user_id == session[:user_id]
			comment.destroy
			flash[:alert] = "댓글이 삭제되었습니다."
			redirect_to "/qna/show/#{comment.post_id}"
		else
			flash[:alert] = "해당 댓글의 삭제 권한이 없습니다."
			redirect_to :back
		end
	end
end

class UsersController < ApplicationController
	
	def index
	@users = User.all.paginate(:page => params[:page], :per_page => 33).order('id ASC')
	end
	
	def top
		
	@users = User.all.paginate(:page => params[:page], :per_page => 33).sort{|a, b| b.sum_score <=> a.sum_score}
	end
	
	def show
    @user = User.find(params[:id])
	@posts = @user.posts.paginate(:page => params[:page], :per_page => 33).order('created_at DESC')
	render 'users/show'
  end
	
	def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = #{current_user.id}"
    @posts = Post.where("#{:user_id} IN (#{following_ids})")
                     
  end

	
	
	def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'users/show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'users/show_follow'
  end
end

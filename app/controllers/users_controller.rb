class UsersController < ApplicationController
	def index
	@users = User.all.paginate(:page => params[:page], :per_page => 33).order('id ASC')
	end
	
	def top
	@users = User.all.paginate(:page => params[:page], :per_page => 33).order('id ASC')
	end
	
	def show
    @user = User.find(params[:id])
	render 'users/show'
  end
	
	def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'profiles/show'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'profiles/show'
  end
end

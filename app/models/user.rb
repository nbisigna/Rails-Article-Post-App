class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	has_attached_file :avatar, styles: { medium: "300x300#", thumb: "100x100#", tiny: "30x30#" }, default_url: "person_:style.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
	
	acts_as_voter
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :posts
	has_many :comments
	has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
	has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
	has_many :following, through: :active_relationships, source: :followed
	has_many :followers, through: :passive_relationships, source: :follower
	
	def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end
	
  def sum_score
	  @score = 0
	posts.each do |post|
	  @postscore = post.weighted_score
	  @score += @postscore
	end
	comments.each do |comment|
	  @commentscore = comment.cached_weighted_score
	  @score += @commentscore * 10
	end
	  @followers = followers.count * 10
	  @score += @followers
	  return @score
  end
	
	def user_rank
		ary = [] 
		@users = User.all
		@users.each do |user|
			ary.push(user.sum_score)
		end
		newAry = ary.sort { |a,b| b.to_i <=> a.to_i }
		@user = User.find(id)
		return newAry.index(@user.sum_score) + 1
	end
	
	
end

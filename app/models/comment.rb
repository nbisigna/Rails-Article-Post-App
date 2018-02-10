class Comment < ApplicationRecord
	belongs_to :post
	belongs_to :user
	# has_ancestry
	default_scope { order('cached_weighted_total DESC') }

end

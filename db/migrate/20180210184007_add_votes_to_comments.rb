class AddVotesToComments < ActiveRecord::Migration[5.1]
  def self.up
    add_column :comments, :cached_comments_total, :integer, :default => 0
    add_column :comments, :cached_comments_score, :integer, :default => 0
    add_column :comments, :cached_comments_up, :integer, :default => 0
    add_column :comments, :cached_comments_down, :integer, :default => 0
    add_column :comments, :cached_weighted_score, :integer, :default => 0
    add_column :comments, :cached_weighted_total, :integer, :default => 0
    add_column :comments, :cached_weighted_average, :float, :default => 0.0
    add_index  :comments, :cached_comments_total
    add_index  :comments, :cached_comments_score
    add_index  :comments, :cached_comments_up
    add_index  :comments, :cached_comments_down
    add_index  :comments, :cached_weighted_score
    add_index  :comments, :cached_weighted_total
    add_index  :comments, :cached_weighted_average

    # Uncomment this line to force caching of existing votes
    # Post.find_each(&:update_cached_votes)
  end

  def self.down
    remove_column :comments, :cached_comments_total
    remove_column :comments, :cached_comments_score
    remove_column :comments, :cached_comments_up
    remove_column :comments, :cached_comments_down
    remove_column :comments, :cached_weighted_score
    remove_column :comments, :cached_weighted_total
    remove_column :comments, :cached_weighted_average
  end
end
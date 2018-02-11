class AddVideoToPosts < ActiveRecord::Migration[5.1]
  def self.up
    add_attachment :posts, :video
    add_column :posts, :video_meta, :string
  end

  def self.down
    remove_attachment :posts, :video
    remove_column :posts, :video_meta
  end
end
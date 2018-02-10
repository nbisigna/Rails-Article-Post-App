class Post < ApplicationRecord
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  # validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  has_attached_file :video, styles: {
    :medium => {
      :geometry => "320x240>",
      :format => 'mp4'
    },
    :thumb => { :geometry => "100x100>", :format => 'jpeg', :time => 5}
  }, :processors => [:ffmpeg]

  do_not_validate_attachment_file_type(:image)
  do_not_validate_attachment_file_type(:video)

  acts_as_votable
  belongs_to :user
	has_many :comments
	validate :has_a_field
	
	def has_a_field
  fields = [:title, :body, :image, :video]

  unless fields.any? { |field| self.send(field).present? }
    errors.add(:base, 'Please fill in a field before making a post.')
  end
	end

  scope :created_between, lambda {|start_date, end_date| where("created_at >= ? AND created_at <= ?", start_date, end_date )}
end

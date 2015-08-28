class Bootsy::Image
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :image_gallery

  mount_uploader :image_file, Bootsy::ImageUploader

  validates_presence_of :image_file, :image_gallery_id

  def id; _id.to_s; end

end

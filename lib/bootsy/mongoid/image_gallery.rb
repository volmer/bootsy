class Bootsy::ImageGallery
  include Mongoid::Document
  include Mongoid::Timestamps


  belongs_to :bootsy_resource, polymorphic: true
  has_many :images, dependent: :destroy

  scope :destroy_orphans, lambda { |time_limit|
    where(
      'created_at < ? AND bootsy_resource_id IS NULL',
      time_limit
    ).destroy_all
  }

  def id; _id.to_s; end

end

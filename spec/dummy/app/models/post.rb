class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true

  accepts_nested_attributes_for :comments

  default_scope { order(:created_at).reverse_order }
end

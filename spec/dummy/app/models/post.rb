class Post < ActiveRecord::Base
  include Bootsy::Container

  default_scope { order(:created_at).reverse_order }

  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments

  validates_presence_of :title, :content
end

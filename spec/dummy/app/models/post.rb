class Post < ActiveRecord::Base
  include Bootsy::Container

  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments

  validates_presence_of :title, :content
end

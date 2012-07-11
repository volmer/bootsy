class Post < ActiveRecord::Base
  include Bootsy::MediaContainer
  attr_accessible :content, :title

  has_many :comments, dependent: :destroy

  validates_presence_of :title, :content
end

class Post < ActiveRecord::Base
  include Bootsy::Container

  has_many :comments, dependent: :destroy

  validates_presence_of :title, :content
end

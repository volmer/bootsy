class Post < ActiveRecord::Base
  include Bootsy::MediaContainer
  attr_accessible :content, :title

  validates_presence_of :title, :content
end

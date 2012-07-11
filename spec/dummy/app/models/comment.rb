class Comment < ActiveRecord::Base
  belongs_to :post
  attr_accessible :author, :content

  validates_presence_of :author, :content
end

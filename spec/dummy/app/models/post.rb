# frozen_string_literal: true
class Post < ActiveRecord::Base
  include Bootsy::Container

  default_scope { order(:created_at).reverse_order }

  has_many :comments, dependent: :destroy

  validates_presence_of :title, :content

  accepts_nested_attributes_for :comments
end

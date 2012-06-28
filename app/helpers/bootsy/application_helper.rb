module Bootsy
  module ApplicationHelper
    def refresh_btn gallery, collection
      gallery = nil unless gallery.nil? || gallery.persisted?
      link_to 'Refresh', [bootsy, gallery, collection], remote: true, :class => 'btn btn-mini refresh_btn'
    end
  end
end

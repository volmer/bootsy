module Bootsy
  module ApplicationHelper
    def refresh_btn gallery, collection
      link_to t('bootsy.refresh'), [bootsy, resource_or_nil(gallery), collection], remote: true, :class => 'btn btn-mini refresh_btn'
    end

    def resource_or_nil resource
      resource = nil unless resource.nil? || resource.persisted?
      resource
    end
  end
end

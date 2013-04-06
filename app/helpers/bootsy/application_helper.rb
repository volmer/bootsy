module Bootsy
  module ApplicationHelper
    def refresh_btn gallery=nil
      link_to t('bootsy.action.refresh'), [bootsy, resource_or_nil(gallery), :images], remote: true, class: 'btn btn-mini refresh_btn'
    end

    def resource_or_nil resource
      resource if resource.present? && resource.persisted?
    end
  end
end

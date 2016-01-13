module Bootsy
  module ApplicationHelper
    def refresh_btn
      link_to t('bootsy.action.refresh'),
              '#refresh-gallery',
              class: 'btn btn-default btn-sm refresh-btn'
    end

    def caption_field
      text_field_tag 'image_gallery_caption',
                 '',
                 class: 'form-control bootsy-image-caption',
                 placeholder: t('bootsy.fields.caption_placeholder')
    end

    def resource_or_nil(resource)
      resource if resource.present? && resource.persisted?
    end
  end
end

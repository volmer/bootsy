module Bootsy
  module FormHelper
    def bootsy_area(object_name, method, options = {})
      container = options[:container] || options[:object]

      output = self.text_area(object_name, method, text_area_options(options))

      if output.present? && enable_uploader?(options)
        container.bootsy_image_gallery_id ||= Bootsy::ImageGallery.create!.id

        output += self.render('bootsy/images/modal', container: container)

        if container.new_record?
          output += self.hidden_field(object_name, :bootsy_image_gallery_id, class: 'bootsy_image_gallery_id')
        end
      end

      output
    end

    private

    def enable_uploader?(options)
      if options[:uploader] == false
        false
      elsif options[:container].is_a?(Container)
        true
      elsif options[:container].blank? && options[:object].is_a?(Container)
        true
      else
        false
      end
    end

    def tag_class(options)
      classes = if options[:class].blank?
        []
      elsif options[:class].kind_of?(Array)
        options[:class]
      else
        [options[:class]]
      end

      classes << 'bootsy_text_area'
    end

    def data_options(options)
      (options[:data] || {}).merge Hash[ bootsy_options(options).map { |k,v| ["bootsy-#{k}", v] } ]
    end

    def bootsy_options(options)
      Bootsy.editor_options.
        merge(options[:editor_options] || {}).
        merge(uploader: enable_uploader?(options))
    end

    def text_area_options(options)
      options.except(
        :container,
        :uploader,
        :editor_options
      ).merge(
        data: data_options(options),
        class: tag_class(options)
      )
    end
  end
end

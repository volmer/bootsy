module Bootsy
  module FormHelper
    def bootsy_area(object, method, options = {})
      container = options.delete(:container)
      bootsy_options = Bootsy.editor_options.merge(options.delete(:editor_options) || {})

      bootsy_options[:uploader] = enable_uploader?(object, options.delete(:uploader), container)

      options[:data] = data_options(options, bootsy_options)
      options[:class] = class_attr(options)

      output = self.text_area(object_name(object), method, options)

      if bootsy_options[:uploader]
        output += self.render 'bootsy/images/modal', { container: container || object }

        if container.blank? || (container == object)
          output += self.hidden_field(object_name(object), :bootsy_image_gallery_id, class: 'bootsy_image_gallery_id')
        end
      end

      output
    end

    private

    def enable_uploader?(object, uploader, container)
      if uploader == false
        false
      elsif container.is_a? Container
        true
      elsif container.blank? && object.is_a?(Container)
        true
      else
        false
      end
    end

    def class_attr(options)
      classes = if options[:class].blank?
        []
      elsif options[:class].kind_of?(Array)
        options[:class]
      else
        [options[:class]]
      end

      classes << 'bootsy_text_area'
    end

    def object_name(object)
      if object.is_a?(String) || object.is_a?(Symbol)
        object
      else
        ActiveModel::Naming.param_key(object.class)
      end
    end

    def data_options(options, bootsy_options)
      (options[:data] || {}).merge Hash[ bootsy_options.map { |k,v| ["bootsy-#{k}", v] } ]
    end
  end
end

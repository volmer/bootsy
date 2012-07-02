module Bootsy
  module FormHelper
    def bootsy_area object, method, options = {}

      resource = options[:resource]
      options.delete :resource

      if resource.nil? && (object.nil? || object.is_a?(String) || object.is_a?(Array) || object.is_a?(Symbol))
        raise PedroError
      end

      object_name = object.class.name.underscore
      
      output = self.render 'bootsy/images/modal', {resource: resource || object}
      output += self.text_area object_name, method, options.merge({:class => 'bootsy_text_area'}){|key, oldval, newval| "#{oldval} #{newval}"}
      if resource.nil? || (resource == object)
        output += self.hidden_field object_name, :bootsy_image_gallery_id, :class => 'bootsy_image_gallery_id'
      end
      output
    end

    def self.included arg
      ActionView::Helpers::FormBuilder.send :include, Bootsy::FormBuilder
    end
  end
end

module Bootsy::FormBuilder
  def bootsy_area method, options = {}
    @template.bootsy_area @object, method, options
  end
end

ActionView::Helpers::FormHelper.send :include, Bootsy::FormHelper
module Bootsy
  module FormHelper
    def bootsy_area object, method, resource = nil
      resource ||= object
      if resource.nil?
        raise PedroError
      end

      object_name = object.class.name.underscore
      

      output = self.render 'bootsy/images/modal', {resource: resource}
      output += self.text_area object_name, method
      output += self.hidden_field object_name, :bootsy_image_gallery_id, :class => 'bootsy_image_gallery_id'
      output
    end

    def self.included arg
      ActionView::Helpers::FormBuilder.send :include, Bootsy::FormBuilder
    end
  end
end

module Bootsy::FormBuilder
  def bootsy_area method, resource = nil
    @template.bootsy_area @object, method, resource
  end
end

ActionView::Helpers::FormHelper.send :include, Bootsy::FormHelper
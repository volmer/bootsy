module Bootsy
  module FormHelper
    def bootsy_area object, method, resource = nil
      resource ||= object
      if resource.nil?
        raise PedroError
      end
      

      output = self.render 'bootsy/images/modal', {resource: resource}
      output += self.text_area object.class.name.underscore, method
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
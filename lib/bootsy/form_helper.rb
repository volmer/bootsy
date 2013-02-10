module Bootsy
  module FormHelper
    def bootsy_area object, method, options = {}
      enable_uploader = true

      foreign_container = options.delete :container
      data = options.delete(:editor_options) || {}

      unless foreign_container.kind_of?(Container) || (foreign_container.nil? && object.kind_of?(Container))
        data[:uploader] = false
      end

      enable_uploader = false if data[:uploader] == false

      data[:locale] = I18n.locale

      options[:data] = options[:data] ? options[:data] + data : data

      object_name = object.class.name.underscore

      output = raw ''
      
      output = self.render 'bootsy/images/modal', {container: foreign_container || object} if enable_uploader

      options[:class] = (options[:class].nil? ? [] : (options[:class].kind_of?(Array) ? options[:class] : [options[:class]])) + [:bootsy_text_area]
    
      output += self.text_area object_name, method, options

      if enable_uploader
        if foreign_container.nil? || (foreign_container == object)
          output += self.hidden_field object_name, :bootsy_image_gallery_id, :class => 'bootsy_image_gallery_id'
        end
      end
      
      output
    end
  end
end
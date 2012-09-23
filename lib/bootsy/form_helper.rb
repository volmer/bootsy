module Bootsy
  module FormHelper
    def bootsy_area object, method, options = {}

      foreign_container = options.delete :container
      enable_uploader = true

      unless foreign_container.kind_of?(Container) || (foreign_container.nil? && object.kind_of?(Container))
        enable_uploader = false
      end

      editor_options = options.delete :editor_options

      unless editor_options.nil?
        enable_uploader = false if editor_options[:uploader] == false
        options[:'data-alert-unsaved'] = 'false' if editor_options[:alert_unsaved] == false
        options[:'data-enable-font-styles'] = 'false' if editor_options[:font_styles] == false
        options[:'data-enable-emphasis'] = 'false' if editor_options[:emphasis] == false
        options[:'data-enable-lists'] = 'false' if editor_options[:lists] == false
        options[:'data-enable-html'] = 'true' if editor_options[:html] == true
        options[:'data-enable-link'] = 'false' if editor_options[:link] == false
        options[:'data-enable-image'] = 'false' if editor_options[:image] == false
        options[:'data-enable-color'] = 'false' if editor_options[:color] == false
      end

      options[:'data-enable-uploader'] = 'false' unless enable_uploader

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
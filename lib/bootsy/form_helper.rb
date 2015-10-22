module Bootsy
  # Public: Module to include Bootsy in `ActionView::Base`.
  module FormHelper
    mattr_accessor(:id_count, instance_accessor: false) { 0 }

    # Public: Return a textarea element with proper attributes to
    # be loaded as a WYSIWYG editor.
    #
    # object_name - The String or Symbol identifier of the object assigned
    #               to the template.
    #
    # method      - The Symbol attribute name on the object assigned to the
    #               form builder that will tailor the editor.
    #
    # options     - The Hash of options used to enable/disable features of
    #               the editor (default: {}):
    #               :uploader       - The Boolean value used to enable/disable
    #                                 the image upload feature. Default: true.
    #               :editor_options - The Hash of options with Boolean values
    #                                 usedto enable/disable features of the
    #                                 editor. Available options are described in
    #                                 the Bootsy initializer file (which is the
    #                                 default for this argument).
    def bootsy_editor(object_name, method, options = {})
      options = trix_options(options)

      content_tag('trix-editor', '', options) +
        hidden_field(object_name, method, id: options[:input])
    end

    private

    def enable_uploader?(options)
      options[:uploader] != false
    end

    def data_options(options)
      (options[:data] || {}).deep_merge(
        Hash[bootsy_options(options).map do |key, value|
          ["bootsy-#{key}", value]
        end]
      )
    end

    def bootsy_options(options)
      {}.merge(options[:editor_options] || {})
        .merge(uploader: enable_uploader?(options))
    end

    def class_options(options)
      classes = options[:class]
      classes = classes.to_s.split(' ') unless classes.is_a?(Array)
      classes << 'bootsy-content'
    end

    def trix_options(options)
      options.merge(
        class: class_options(options),
        input: input_id(options),
        data: data_options(options)
      )
    end

    def input_id(options)
      options[:id] || "trix-editor-#{Bootsy::FormHelper.id_count += 1}"
    end
  end
end

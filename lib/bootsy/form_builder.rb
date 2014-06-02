module Bootsy
  # Public: Convenience module to include Bootsy
  # in `ActionView::Helpers::FormBuilder`.
  module FormBuilder
    # Public: Return a textarea element with proper attributes to
    # be loaded as a WYSIWYG editor.
    #
    # method - The Symbol attribute name on the object assigned to the
    #          form builder that will tailor the editor.
    #
    # options - The Hash of options used to enable/disable features of
    #           the editor (default: {}).
    #           Available options are:
    def bootsy_area(method, options = {})
      @template.bootsy_area(@object_name, method, objectify_options(options))
    end
  end
end

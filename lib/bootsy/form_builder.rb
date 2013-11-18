module Bootsy
  module FormBuilder
    def bootsy_area method, options = {}
      @template.bootsy_area @object_name, method, objectify_options(options)
    end
  end
end

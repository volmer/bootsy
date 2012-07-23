module Bootsy
  module FormBuilder
    def bootsy_area method, options = {}
      @template.bootsy_area @object, method, options
    end
  end
end
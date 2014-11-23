require 'simple_form'

# Public: A SimpleForm Input to wrap Bootsy areas
class BootsyInput < SimpleForm::Inputs::Base
  enable :placeholder, :maxlength, :container, :editor_options, :uploader

  def input(wrapper_options = nil)
    bootsy_params = [:editor_options, :container, :uploader]
    input_html_options.merge!(
      input_options.select { |key, _| bootsy_params.include?(key) }
    )

    # Check presence of `merge_wrapper_options` to keep
    # compatibility with both Simple Form 3.0 and 3.1.
    merged_input_options =
      if respond_to?(:merge_wrapper_options, true)
        merge_wrapper_options(input_html_options, wrapper_options)
      else
        input_html_options
      end

    @builder.bootsy_area(attribute_name, merged_input_options)
  end
end

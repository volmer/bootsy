require 'simple_form'

class BootsyInput < SimpleForm::Inputs::Base
  enable :placeholder, :maxlength, :container, :editor_options, :uploader

  def input(wrapper_options = nil)
    bootsy_params = [:editor_options, :container, :uploader]
    input_html_options.merge!(input_options.select {|k,v| bootsy_params.include?(k) })
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    @builder.bootsy_area(attribute_name, merged_input_options)
  end
end

require 'simple_form'

class BootsyInput < SimpleForm::Inputs::Base
  enable :placeholder, :maxlength, :container, :editor_options, :uploader

  def input
    bootsy_params = [:editor_options, :container, :uploader]
    input_html_options.merge! input_options.select {|k,v| bootsy_params.include? k }
    @builder.bootsy_area attribute_name, input_html_options
  end
end

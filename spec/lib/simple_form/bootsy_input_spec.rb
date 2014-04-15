require 'spec_helper'

describe BootsyInput do
  let(:builder){ double.as_null_object }

  subject {
    BootsyInput.new(builder, :my_text_attr, '', 'bootsy',
      placeholder: 'a placeholder', maxlength: 50, container: :a_container,
      editor_options: :some_options, uploader: :uploader_value)
  }

  describe 'options enabled' do
    its(:input_options) { should have_key(:placeholder) }
    its(:input_options) { should have_key(:container) }
    its(:input_options) { should have_key(:editor_options) }
    its(:input_options) { should have_key(:maxlength) }
    its(:input_options) { should have_key(:uploader) }
  end

  describe '#input' do
    it 'passes the attribute_name to the bootsy_area' do
      expect(builder).to receive(:bootsy_area).with(:my_text_attr, anything)
      subject.input
    end

    it 'passes the input_html_options to the bootsy_area' do
      expect(builder).to receive(:bootsy_area).with(anything, subject.input_html_options)
      subject.input
    end

    context 'when a :container is passed' do
      it 'adds the :container to input_html_options[:container]' do
        expect(builder).to receive(:bootsy_area).with(anything, hash_including(container: :a_container))
        subject.input
      end
    end

    context 'when :editor_options are passed' do
      it 'adds the :editor_options to input_html_options[:editor_options]' do
        expect(builder).to receive(:bootsy_area).with(anything, hash_including(editor_options: :some_options))
        subject.input
      end
    end

    context 'when :uploader is passed' do
      it 'adds :uploader to input_html_options[:uploader]' do
        expect(builder).to receive(:bootsy_area).with(anything, hash_including(uploader: :uploader_value))
        subject.input
      end
    end

    it 'passes the wrapper options to bootsy_area' do
      expect(builder).to receive(:bootsy_area).with(anything, hash_including(maxlength: 10))
      subject.input(maxlength: 10)
    end
  end
end

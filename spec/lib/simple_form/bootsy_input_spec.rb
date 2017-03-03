# frozen_string_literal: true
require 'rails_helper'

describe BootsyInput do
  let(:builder) { double.as_null_object }

  subject do
    BootsyInput.new(
      builder,
      :my_text_attr,
      '',
      'bootsy',
      placeholder: 'a placeholder',
      maxlength: 50,
      container: :a_container,
      editor_options: :some_options,
      uploader: :uploader_value
    )
  end

  it 'has the proper options enabled' do
    expect(subject.input_options).to have_key(:placeholder)
    expect(subject.input_options).to have_key(:container)
    expect(subject.input_options).to have_key(:editor_options)
    expect(subject.input_options).to have_key(:maxlength)
    expect(subject.input_options).to have_key(:uploader)
  end

  describe '#input' do
    it 'passes the attribute_name to the bootsy_area' do
      expect(builder).to receive(:bootsy_area).with(:my_text_attr, anything)
      subject.input
    end

    it 'passes the input_html_options to the bootsy_area' do
      expect(builder).to receive(:bootsy_area)
        .with(anything, subject.input_html_options)
      subject.input
    end

    context 'when a :container is passed' do
      it 'adds the :container to input_html_options[:container]' do
        expect(builder).to receive(:bootsy_area)
          .with(anything, hash_including(container: :a_container))
        subject.input
      end
    end

    context 'when :editor_options are passed' do
      it 'adds the :editor_options to input_html_options[:editor_options]' do
        expect(builder).to receive(:bootsy_area)
          .with(anything, hash_including(editor_options: :some_options))
        subject.input
      end
    end

    context 'when :uploader is passed' do
      it 'adds :uploader to input_html_options[:uploader]' do
        expect(builder).to receive(:bootsy_area)
          .with(anything, hash_including(uploader: :uploader_value))
        subject.input
      end
    end

    it 'passes the wrapper options to bootsy_area' do
      expect(builder).to receive(:bootsy_area)
        .with(anything, hash_including(maxlength: 10))
      subject.input(maxlength: 10)
    end
  end
end

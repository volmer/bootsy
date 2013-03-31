require 'spec_helper'

describe Bootsy::FormHelper do
  let :form do
    s = double(text_area: '<textarea field>', 
               hidden_field: '<hidden field>').extend Bootsy::FormHelper
    s.stub(:render) {|template, variables| template+variables[:container].to_s }
    s
  end

  let(:container){ double(content: 'abc').extend Bootsy::Container }

  describe '#bootsy_area' do
    subject { form.bootsy_area :object, :content }

    it 'renders a text_area with class bootsy_text_area' do
      form.should_receive(:text_area).with :object, :content, hash_including(class: ['bootsy_text_area'])
      should include('<textarea field>')
    end

    context 'when the object is a Bootsy Container' do
      subject { form.bootsy_area container, :content }

      it 'renders a hidden_field with class and name bootsy_image_gallery_id' do
        form.should_receive(:hidden_field).with container.class.name.underscore, :bootsy_image_gallery_id, {class: 'bootsy_image_gallery_id'}
        should include('<hidden field>')
      end

      it 'renders the upload modal' do
        should include('bootsy/images/modal')
        should include(container.to_s)
      end
    end

    context 'when a non-container is passed' do
      subject { form.bootsy_area :non_container, :content }

      it 'adds data-bootsy-uploader="false"' do
        form.should_receive(:text_area).with anything, anything, hash_including(data: hash_including('bootsy-uploader' => false))
        subject
      end

      it { should_not include('<hidden field>') }

      it 'does not render the upload modal' do
        should_not include('bootsy/images/modal')
      end
    end

    context 'when a specific container is passed' do
      let(:specific){ double('specific').extend Bootsy::Container }

      subject { form.bootsy_area container, :content, {container: specific} }

      it 'renders the upload modal' do
        should include('bootsy/images/modal')
        should include(specific.to_s)
      end

      it { should_not include('<hidden field>') }

      context 'when the specific container is not a Container' do
        subject { form.bootsy_area container, :content, {container: double('non-container')} }

        it 'adds data-bootsy-uploader="false"' do
          form.should_receive(:text_area).with anything, anything, hash_including(data: hash_including('bootsy-uploader' => false))
          subject
        end

        it 'does not render the upload modal' do
          should_not include('bootsy/images/modal')
        end
      end
    end

    context 'when uploader: false is passed' do
      subject { form.bootsy_area container, :content, uploader: false }

      it 'adds data-bootsy-uploader="false"' do
        form.should_receive(:text_area).with anything, anything, hash_including(data: hash_including('bootsy-uploader' => false))
        subject
      end

      it { should_not include('<hidden field>') }

      it 'does not render the upload modal' do
        should_not include('bootsy/images/modal')
      end
    end

    context 'when editor_options are passed' do
      subject { form.bootsy_area container, :content, editor_options: {op1: '1', op2: '2'} }

      it 'passes the editor options to the text area as data-bootsy attributes' do
        form.should_receive(:text_area).with anything, anything, hash_including(data: hash_including('bootsy-op1' => '1', 'bootsy-op2' => '2'))
        subject
      end
    end

    context 'when editor options are defined on the intialize file' do
      before { Bootsy.stub editor_options: {global1: 1, global2: 2} }

      it 'passes them to the text area as data-bootsy attributes' do
        form.should_receive(:text_area).with anything, anything, hash_including(data: hash_including('bootsy-global1' => 1, 'bootsy-global2' => 2))
        subject
      end
    end

    context 'when additional options are passed' do
      subject { form.bootsy_area container, :content, op1: '1', op2: '2', data: {a: 1, b: 2} }

      it 'resends them to the text_area' do
        form.should_receive(:text_area).with anything, anything, hash_including(op1: '1', op2: '2', data: hash_including(a: 1, b: 2))
        subject
      end
    end

    context 'when custom HTML classes are passed' do
      context 'as a string' do
        subject { form.bootsy_area container, :content, class: 'class1 class2' }

        it 'resends them to the text_area' do
          form.should_receive(:text_area).with anything, anything, hash_including(class: ['class1 class2', 'bootsy_text_area'])
          subject
        end
      end

      context 'as an array' do
        subject { form.bootsy_area container, :content, class: ['class1', 'class2'] }

        it 'resends them to the text_area' do
          form.should_receive(:text_area).with anything, anything, hash_including(class: ['class1', 'class2', 'bootsy_text_area'])
          subject
        end
      end
    end
  end
end
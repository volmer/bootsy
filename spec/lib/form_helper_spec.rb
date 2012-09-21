require 'spec_helper'

describe Bootsy::FormHelper do
  let :dummy_object do
    Class.new do
      extend Bootsy::FormHelper
    end
  end

  it 'includes the method bootsy_area' do
    dummy_object.should respond_to(:bootsy_area)
  end

  describe '#bootsy_area' do
    before :each do
      dummy_object.stub(:render) {|template, variables| variables[:container].to_s }
      dummy_object.stub(:text_area).and_return('<textarea>')
      dummy_object.stub(:hidden_field).and_return('<hidden>')
      @container = double('container').extend(Bootsy::Container)
      @container.stub(:content)
    end

    it 'renders a text_area with the HTML class :bootsy_text_area' do
      dummy_object.should_receive(:text_area).with(anything, :content, hash_including(:class => [:bootsy_text_area])).and_return('<textarea>')
      dummy_object.bootsy_area(@container, :content).should include('<textarea>')
    end

    it 'renders a hidden_field' do
      dummy_object.bootsy_area(@container, :content).should include('<hidden>')
    end

    it 'renders the gallery of the container' do
      dummy_object.bootsy_area(@container, :content).should include(@container.to_s)
    end

    it 'passes the options hash to the text_area' do
      dummy_object.should_receive(:text_area).with(anything, :content, hash_including(:class => [:bootsy_text_area], op1: '1', op2: '2')).and_return('<textarea>')
      dummy_object.bootsy_area(@container, :content, {op1: '1', op2: '2'}).should include('<textarea>')
    end

    it 'appends custom HTML classes passed as string on the text_area' do
      dummy_object.should_receive(:text_area).with(anything, :content, hash_including(:class => ['my_html_class', :bootsy_text_area])).and_return('<textarea>')
      dummy_object.bootsy_area(@container, :content, {:class => 'my_html_class', op1: '1', op2: '2'}).should include('<textarea>')
    end

    it 'appends custom HTML classes passed as array on the text_area' do
      dummy_object.should_receive(:text_area).with(anything, :content, hash_including(:class => ['my_html_class', :bootsy_text_area])).and_return('<textarea>')
      dummy_object.bootsy_area(@container, :content, {:class => ['my_html_class'], op1: '1', op2: '2'}).should include('<textarea>')
    end

    context 'when a non-container is passed' do
      it "adds data-enable-uploader='false'" do
        dummy_object.should_receive(:text_area).with(anything, anything, hash_including(:'data-enable-uploader' => 'false'))
        dummy_object.bootsy_area(double('container'), :content)
      end
    end

    context 'when a specific container is passed' do

      before :each do
        @specific = double('specific').extend(Bootsy::Container)
      end

      it 'renders the gallery of the specific container' do
        dummy_object.bootsy_area(@container, :content, {container: @specific}).should include(@specific.to_s)
      end

      it 'does not render a hidden_field' do
        dummy_object.bootsy_area(@container, :content, {container: @specific}).should_not include('<hidden>')
      end

      context 'when a non-container specific container is passed' do
        it "adds data-enable-uploader='false'" do
          dummy_object.should_receive(:text_area).with(anything, anything, hash_including(:'data-enable-uploader' => 'false'))
          dummy_object.bootsy_area(double('container'), :content)
        end
      end
    end

    context 'when editor_options is passed' do
      it "adds data-enable-uploader='false' for uploader: false" do
        dummy_object.should_receive(:text_area).with(anything, anything, hash_including(:'data-enable-uploader' => 'false'))
        dummy_object.bootsy_area(@container, :content, editor_options: {uploader: false})
      end

      it "adds data-alert-unsaved='false' for alert_unsaved: false" do
        dummy_object.should_receive(:text_area).with(anything, anything, hash_including(:'data-alert-unsaved' => 'false'))
        dummy_object.bootsy_area(@container, :content, editor_options: {alert_unsaved: false})
      end

      it "adds data-enable-font-styles='false' for font_styles: false" do
        dummy_object.should_receive(:text_area).with(anything, anything, hash_including(:'data-enable-font-styles' => 'false'))
        dummy_object.bootsy_area(@container, :content, editor_options: {font_styles: false})
      end

      it "adds data-enable-emphasis='false' for emphasis: false" do
        dummy_object.should_receive(:text_area).with(anything, anything, hash_including(:'data-enable-emphasis' => 'false'))
        dummy_object.bootsy_area(@container, :content, editor_options: {emphasis: false})
      end

      it "adds data-enable-lists='false' for lists: false" do
        dummy_object.should_receive(:text_area).with(anything, anything, hash_including(:'data-enable-lists' => 'false'))
        dummy_object.bootsy_area(@container, :content, editor_options: {lists: false})
      end

      it "adds data-enable-html='true' for html: true" do
        dummy_object.should_receive(:text_area).with(anything, anything, hash_including(:'data-enable-html' => 'true'))
        dummy_object.bootsy_area(@container, :content, editor_options: {html: true})
      end

      it "adds data-enable-link='false' for link: false" do
        dummy_object.should_receive(:text_area).with(anything, anything, hash_including(:'data-enable-link' => 'false'))
        dummy_object.bootsy_area(@container, :content, editor_options: {link: false})
      end

      it "adds data-enable-image='false' for image: false" do
        dummy_object.should_receive(:text_area).with(anything, anything, hash_including(:'data-enable-image' => 'false'))
        dummy_object.bootsy_area(@container, :content, editor_options: {image: false})
      end

      it "adds data-enable-color='false' for color: false" do
        dummy_object.should_receive(:text_area).with(anything, anything, hash_including(:'data-enable-color' => 'false'))
        dummy_object.bootsy_area(@container, :content, editor_options: {color: false})
      end
    end
  end
end
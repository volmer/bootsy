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
      dummy_object.stub(:render) {|template, variables| variables[:resource].to_s }
      dummy_object.stub(:text_area).and_return('<textarea>')
      dummy_object.stub(:hidden_field).and_return('<hidden>')
      @resource = double('resource').extend(Bootsy::MediaContainer)
      @resource.stub(:content)
    end

    it 'renders a text_area with the HTML class :bootsy_text_area' do
      dummy_object.should_receive(:text_area).with(anything, :content, hash_including(:class => [:bootsy_text_area])).and_return('<textarea>')
      dummy_object.bootsy_area(@resource, :content).should include('<textarea>')
    end

    it 'renders a hidden_field' do
      dummy_object.bootsy_area(@resource, :content).should include('<hidden>')
    end

    it 'renders the gallery of the resource' do
      dummy_object.bootsy_area(@resource, :content).should include(@resource.to_s)
    end

    it 'passes the options hash to the text_area' do
      dummy_object.should_receive(:text_area).with(anything, :content, hash_including(:class => [:bootsy_text_area], op1: '1', op2: '2')).and_return('<textarea>')
      dummy_object.bootsy_area(@resource, :content, {op1: '1', op2: '2'}).should include('<textarea>')
    end

    it 'appends custom HTML classes passed as string on the text_area' do
      dummy_object.should_receive(:text_area).with(anything, :content, hash_including(:class => ['my_html_class', :bootsy_text_area])).and_return('<textarea>')
      dummy_object.bootsy_area(@resource, :content, {:class => 'my_html_class', op1: '1', op2: '2'}).should include('<textarea>')
    end

    it 'appends custom HTML classes passed as array on the text_area' do
      dummy_object.should_receive(:text_area).with(anything, :content, hash_including(:class => ['my_html_class', :bootsy_text_area])).and_return('<textarea>')
      dummy_object.bootsy_area(@resource, :content, {:class => ['my_html_class'], op1: '1', op2: '2'}).should include('<textarea>')
    end

    context 'when a non-media_container is passed' do
      it 'raises an error' do
        expect{
          dummy_object.bootsy_area(double('resource'), :content)
        }.to raise_error(ArgumentError)
      end
    end

    context 'when a specific resource is passed' do

      before :each do
        @specific = double('specific').extend(Bootsy::MediaContainer)
      end

      it 'renders the gallery of the specific resource' do
        dummy_object.bootsy_area(@resource, :content, {resource: @specific}).should include(@specific.to_s)
      end

      it 'does not render a hidden_field' do
        dummy_object.bootsy_area(@resource, :content, {resource: @specific}).should_not include('<hidden>')
      end

      context 'when a non-media_container specific resource is passed' do
        it 'raises an error' do
          expect{
            dummy_object.bootsy_area(@resource, :content, {resource: double('other_specific')})
          }.to raise_error(ArgumentError)
        end
      end
    end
  end
end
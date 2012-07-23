require 'spec_helper'

describe Bootsy::FormBuilder do
  let :dummy_object do
    d = double('dummy')
    d.extend Bootsy::FormBuilder
    d.instance_variable_set :@object, 1
    d.instance_variable_set :@template, double('template')
    d
  end

  it 'includes the method bootsy_area' do
    dummy_object.should respond_to(:bootsy_area)
  end

  describe '#bootsy_area' do
    it 'calls the template\'s bootsy_area passing its arguments and the @object' do
      dummy_object.instance_variable_get(:@template).should_receive(:bootsy_area).with(1, :content, {op: 'op'})
      dummy_object.bootsy_area(:content, {op: 'op'})
    end

    it 'receives an optional hash of options' do
      dummy_object.instance_variable_get(:@template).should_receive(:bootsy_area).with(1, :content, {})
      dummy_object.bootsy_area(:content)
    end
  end
end
require 'spec_helper'

describe Bootsy::FormBuilder do
  subject :extended_builder do
    d = double('extended builder')
    d.extend Bootsy::FormBuilder
    d.instance_variable_set :@object, 1
    d.instance_variable_set :@template, double('template')
    d
  end

  it { should respond_to(:bootsy_area) }

  describe '#bootsy_area' do
    it 'calls the template\'s bootsy_area passing its arguments and the @object' do
      subject.instance_variable_get(:@template).should_receive(:bootsy_area).with(1, :content, {op: 'op'})
      subject.bootsy_area(:content, {op: 'op'})
    end

    it 'receives an optional hash of options' do
      subject.instance_variable_get(:@template).should_receive(:bootsy_area).with(1, :content, {})
      subject.bootsy_area(:content)
    end
  end
end
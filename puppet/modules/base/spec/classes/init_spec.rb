require 'spec_helper'
describe 'startup' do
  context 'with default values for all parameters' do
    it { should contain_class('startup') }
  end
end

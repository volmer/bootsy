require 'rails_helper'

describe Bootsy::Engine do
  it 'includes helpers in ApplicationController' do
    expect(ApplicationController._helpers.included_modules).to include(Bootsy::ApplicationHelper)
  end
end

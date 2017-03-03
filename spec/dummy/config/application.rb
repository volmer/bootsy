# frozen_string_literal: true
require_relative 'boot'

require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)
require 'bootsy'

module Dummy
  class Application < Rails::Application
  end
end

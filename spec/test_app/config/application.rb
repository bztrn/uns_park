require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)
require "uns_park"

module TestApp
  class Application < Rails::Application
    attr_reader :complications
    
    def add_complication(comp)
      @complications ||= []
      @complications << comp
    end
    self.railties.each do |e|
      if e.respond_to? :complication
        add_complication(e.complication) 
      end
    end

    ActionDispatch::Callbacks.after do
      return unless (Rails.env.development? || Rails.env.test?)

      unless FactoryGirl.factories.blank? # first init will load factories, this should only run on subsequent reloads
        FactoryGirl.factories.clear
        FactoryGirl.find_definitions
      end
    end

    config.active_record.raise_in_transactional_callbacks = true
  end
end


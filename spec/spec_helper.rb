# spec/spec_helper.rb
require 'rack/test'
require 'rspec'
require 'coveralls'

ENV['RACK_ENV'] = 'test'

Coveralls.wear!

require File.expand_path '../../app/application.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure { |c| c.include RSpecMixin }

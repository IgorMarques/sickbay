require 'sinatra'
require 'json'

require 'pry'

require_relative 'health_checker'

get '/' do
  HealthChecker.call(params).to_json
end

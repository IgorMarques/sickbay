require 'sinatra'
require 'json'

require_relative '../lib/sickbay/health_checker'

get '/' do
  HealthChecker.call(params).to_json
end

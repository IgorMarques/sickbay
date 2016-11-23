require 'spec_helper'
require 'webmock/rspec'

describe Sinatra::Application, type: :controller do
  before do
    stub_request(:get, 'http://www.main_app.com/health')
    stub_request(:get, 'http://www.secondary_app.com/health')
  end

  context 'when getting a health check' do
    let(:response) {
      get '/',
      {
        main_service: 'http://www.main_app.com/health',
        secondary_app: 'http://www.secondary_app.com/health',
      }
      last_response
    }

    it 'responds with HTTP 200 OK' do
      expect(response.status).to eq(200)
    end

    it 'returns the health check for each service' do
      expect(response.body).to eq(
        {
          main_service: '200',
          secondary_app: '200'
        }.to_json
      )
    end
  end
end

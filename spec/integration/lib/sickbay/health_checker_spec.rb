require 'spec_helper'
require 'webmock/rspec'

RSpec.describe HealthChecker do
  describe "#call" do
    before do
      stub_request(:get, 'http://www.service1.com')
      stub_request(:get, 'http://www.service2.com')
        .to_return(status: [500, "Internal Server Error"])
      stub_request(:get, 'http://www.service3.com')
    end

    it 'gets the response status for each service' do
      expect(described_class.call(
        service_1: 'http://www.service1.com',
        service_2: 'http://www.service2.com',
        service_3: 'http://www.service3.com',
        service_4: nil
      )).to eq(
        service_1: '200',
        service_2: '500',
        service_3: '200',
        service_4: '0'
      )
    end
  end
end

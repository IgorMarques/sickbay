require 'spec_helper'

RSpec.describe HealthChecker do
  describe "#call" do
    before do
      allow(ServiceHealthChecker).to receive(:call).and_return('200')
    end

    it 'gets the response status for each service' do
      result = described_class.call(
        service_1: 'http://www.service1.com',
        service_2: 'http://www.service2.com',
        service_3: 'http://www.service3.com'
      )

      expect(ServiceHealthChecker).to have_received(:call).with('http://www.service1.com')
      expect(ServiceHealthChecker).to have_received(:call).with('http://www.service2.com')
      expect(ServiceHealthChecker).to have_received(:call).with('http://www.service3.com')

      expect(result).to eq(
        service_1: '200',
        service_2: '200',
        service_3: '200'
      )
    end
  end
end

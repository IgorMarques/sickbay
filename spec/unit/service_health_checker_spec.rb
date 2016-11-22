require 'spec_helper'
require 'webmock/rspec'

RSpec.describe ServiceHealthChecker do
  describe "#call" do
    context 'when param is a url' do
      before do
        stub_request(:get, 'http://www.example.com')
        stub_request(:get, 'https://www.example.com')
      end

      context 'and starts with http://' do
        it 'returns the response status for a get to the called url' do
          expect(described_class.call('http://www.example.com')).to eq('200')
        end
      end

      context 'and starts with https://' do
        it 'returns the response status for a get to the called url' do
          expect(described_class.call('https://www.example.com')).to eq('200')
        end
      end

      context 'but it does not start with http://' do
        it 'returns the response status for a get to the called url' do
          expect(described_class.call('www.example.com')).to eq('200')
        end
      end
    end

    context 'when the param is an unreachable url' do
      before do
        stub_request(:get, 'http://this_is_not_a_url').to_raise(SocketError)
      end

      it 'returns 0' do
        expect(described_class.call('this_is_not_a_url')).to eq('0')
      end
    end

    context 'when the param is nil' do
      it 'returns 0' do
        expect(described_class.call(nil)).to eq('0')
      end
    end
  end
end

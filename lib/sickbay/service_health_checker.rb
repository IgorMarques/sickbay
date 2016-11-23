require 'uri'
require 'net/http'

class ServiceHealthChecker
  class << self
    def call(service_url)
      return '0' if service_url.nil?

      uri = generate_uri(service_url)

      Net::HTTP.get_response(uri).code
    rescue SocketError
      return '0'
    end

    private

    def generate_uri(url)
      if url.start_with?('http://') || url.start_with?('https://')
        return URI(url)
      else
        return URI('http://' + url)
      end
    end
  end
end

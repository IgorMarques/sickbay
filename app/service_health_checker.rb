require 'uri'
require 'net/http'

class ServiceHealthChecker
  def self.call(service_url)
    return '0' if service_url.nil?

    uri = generate_uri(service_url)

    Net::HTTP.get_response(uri).code
  rescue SocketError
    return '0'
  end

  private

  def self.generate_uri(url)
    if url.start_with?('http://') || url.start_with?('https://')
      return URI(url)
    else
      return URI('http://' + url)
    end
  end
end

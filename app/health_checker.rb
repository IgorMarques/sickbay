require_relative 'service_health_checker'

class HealthChecker
  def self.call(services = {})
    services.each_with_object(Hash.new) do |(service_name, service_url), base_hash|
      base_hash[service_name] = ServiceHealthChecker.call(service_url)
    end
  end
end

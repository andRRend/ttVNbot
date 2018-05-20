require 'openssl'
require 'net/http'

module GetJson
    def request (url,login,password)
      uri = URI(url)
      require = Net::HTTP::Get.new(uri)
      require.basic_auth login, password
      response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https',:verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|
        http.request(require)
      end
      return response.body
    rescue
      p 'Net::OpenTimeout'
    end
  end




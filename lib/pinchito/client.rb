module Pinchito
  class Client

    PINCHITO_BASE_URL = 'http://old.pinchito.com'

    def self.get_log(id:)
      connection.get(log_url(id: id)).body
    end

    private

    def self.connection
      Faraday.new(:url => PINCHITO_BASE_URL) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    def self.log_url(id:)
      id.to_s
    end
  end
end

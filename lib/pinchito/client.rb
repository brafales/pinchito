module Pinchito
  class Client

    PINCHITO_BASE_URL = 'http://old.pinchito.com'

    def self.get_log(id:)
      connection.get(log_url(id: id)).body
    end

    def self.search_log(query:)
      connection.get(search_url, {s: query}).body
    end

    def self.tapeta
      connection.get(tapeta_url).body
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

    def self.search_url
      'buscar'
    end

    def self.tapeta_url
      'tapeta'
    end
  end
end

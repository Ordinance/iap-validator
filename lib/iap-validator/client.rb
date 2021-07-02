require 'multi_json'
require 'typhoeus'

module IAPValidator
  class Client
    attr_accessor :url

    SANDBOX_URL = 'https://sandbox.itunes.apple.com/verifyReceipt'.freeze
    PRODUCTION_URL = 'https://buy.itunes.apple.com/verifyReceipt'.freeze

    HEADERS = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    }.freeze

    class << self
      def development
        client = self.new
        client.url = SANDBOX_URL
        client
      end
  
      def production
        client = self.new
        client.url = PRODUCTION_URL
        client
      end
    end

    def initialize
    end

    def verify_receipt(data, options = {})
      url ||= PRODUCTION_URL
      password = options[:password]
      json = if password.nil?
                { 'receipt-data' => data }
              else
                { 'receipt-data' => data, 'password' => password }
              end

      resp = Typhoeus.post(url, body: MultiJson.encode(json), headers: HEADERS)

      return nil unless resp.code == 200

      MultiJson.decode(resp.body)
    end
  end
end

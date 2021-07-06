# frozen_string_literal: true

require 'multi_json'

module IAPValidator
  class Receipt
    # https://developer.apple.com/documentation/appstorereceipts/responsebody
    ATTRIBUTES = %i[
      environment is_retryable latest_receipt latest_receipt_info pending_renewal_info
      original_response receipt status
    ].freeze

    attr_reader(*ATTRIBUTES)

    class << self
      def verify(data, options = {})
        client = !options[:sandbox].nil? ? Client.development : Client.production
        response = client.verify_receipt(data, options)
        new(response: response)
      end
    end

    def initialize(response:)
      self.receipt              = ReceiptInfo.new(receipt: response&.dig('receipt')) if response&.dig('receipt')
      self.status               = response&.dig('status')
      self.environment          = response&.dig('environment')
      self.is_retryable         = response&.dig('is-retryable')
      self.latest_receipt       = response&.dig('latest_receipt')
      self.latest_receipt_info  = response&.dig('latest_receipt_info')
      self.pending_renewal_info = response&.dig('pending_renewal_info')
    end

    def to_hash
      {
        environment: environment,
        is_retryable: is_retryable,
        latest_receipt: latest_receipt,
        latest_receipt_info: latest_receipt_info,
        pending_renewal_info: pending_renewal_info,
        receipt: receipt.to_hash,
        status: status,
      }
    end
    
    private

    attr_writer(*ATTRIBUTES)
  end
end